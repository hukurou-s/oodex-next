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
      err, status = build('.')
      puts "コンパイルエラーです\n\n\n#{err.inspect}\n\n\n" if status != 0
      result = Question.find(question_id).tests.map do |test|
        Open3.capture3(test.test_command)
      end
      puts result
    end
  end

  def build(project_root)
    _, err, status = Open3.capture3("#{project_root}/gradlew clean build")
    return err, status
  end
end
