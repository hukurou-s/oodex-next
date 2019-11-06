# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :problem
  has_many :question_tests
  has_many :tests, through: :question_tests

  def problem
    @problem = Problem.find_by(id: problem_id) if @problem.nil?
    @problem
  end

  def mission
    @mission = Mission.find_by(id: problem.mission_id) if @mission.nil?
    @mission
  end

  def register_test(test_names, labels, pirced_location_ids)
    @registered_tests = Test.of_mission(mission.id)
    result = { test_list: [], error: nil }

    test_names&.each_with_index do |test_name, i|
      @test = new_test(test_name, labels[i], pirced_location_ids[i])
      test = @test.save
      test ? result[:test_list] << test : result[:error] = @test.report_errors && break
    end
    result
  end

  def test_params(name, pirced_location_id)
    {
      mission: mission,
      test_name: name,
      test_command: mission.test_commands[name],
      pierced_location_id: pirced_location_id
    }
  end

  def question_test_params(label)
    {
      question: self,
      pierced_level: label
    }
  end

  def new_test(test_name, label, pirced_location_id)
    test = @registered_tests&.find_by(test_name: test_name)
    test = Test.new(test_params(test_name, pirced_location_id)) if test.nil?

    @question_test = test.question_tests.build(question_test_params(label))
    test
  end

  def report_errors
    logger.info question_errors: errors.full_messages
    "fail to create question #{errors.full_messages.join(' ')}"
  end
end
