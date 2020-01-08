# frozen_string_literal: true

require 'open3'
require 'json'

class QuestionTestWorker
  include Sidekiq::Worker

  sidekiq_options queue: :test, retry: 1

  def perform(submit_id, mission_id, question_id)
    set_before(submit_id, mission_id, question_id)
    project_root = create_tmp_project

    return unless exec_tests(project_root)
    message = @test_result.flatten.map(&:message)

    if @submit.save
      ExerciseActivityChannel.broadcast_to @current_user, status: 'done', message: message
    else
      ExerciseActivityChannel.broadcast_to @current_user, status: 'fail'
    end
  end

  def exec_tests(project_root)
    Dir.chdir(project_root) do
      return false unless can_compile?('.')

      @test_result = @question.tests.map do |test|
        results, = Open3.capture3(test.test_command)
        JSON.parse(results).map do |result|
          @submit.test_results.build(test_result_params(test, result))
        end
      end
    end
    true
  end

  def create_tmp_project
    tmpdir = Dir.mktmpdir
    project_root = @mission.create_submitted_project(@submit.id, tmpdir)
    project_root
  end

  def can_compile?(project_root)
    result = build(project_root)
    return true if result[:status].success?

    ExerciseActivityChannel.broadcast_to(
      @current_user,
      status: 'compile error',
      error: result[:error]
    )
    false
  end

  def build(project_root)
    out, err, status = Open3.capture3("#{project_root}/gradlew clean build -x test")
    {
      out: out,
      error: err,
      status: status
    }
  end

  def test_result_params(test, result)
    {
      submit_id: @submit.id,
      test_id: test.id,
      status: result['status'],
      target: result['target'],
      message: result['message']
    }
  end

  def set_before(submit_id, mission_id, question_id)
    @submit = Submit.find(submit_id)
    @mission = Mission.find(mission_id)
    @question = Question.find(question_id)
    @current_user = User.find(Submit.find(submit_id).user_id)
  end
end
