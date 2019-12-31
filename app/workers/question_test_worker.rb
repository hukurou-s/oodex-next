# frozen_string_literal: true

require 'open3'

class QuestionTestWorker
  include Sidekiq::Worker

  sidekiq_options queue: :test, retry: 1

  def perform(submit_id, mission_id, question_id)
    @mission = Mission.find(mission_id)
    tmpdir = Dir.mktmpdir
    project_root = @mission.create_submitted_project(submit_id, tmpdir)
    Dir.chdir(project_root) do
      status = build('.')
      ExerciseActivityChannel.broadcast_to current_user(submit_id), status: 'fail' if status != 0
      result = Question.find(question_id).tests.map do |test|
        Open3.capture3(test.test_command)
      end
      puts result
    end
    ExerciseActivityChannel.broadcast_to current_user(submit_id), status: 'done'
  end

  def build(project_root)
    _, _, status = Open3.capture3("#{project_root}/gradlew clean build")
    status
  end

  def current_user(submit_id)
    User.find(Submit.find(submit_id).user_id)
  end
end
