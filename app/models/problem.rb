# frozen_string_literal: true

# == Schema Information
#
# Table name: problems
#
#  id         :integer          not null, primary key
#  mission_id :integer          not null
#  name       :string(255)      not null
#  detail     :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Problem < ApplicationRecord
  belongs_to :mission
  has_many :questions
  has_many :problem_tests
  has_many :tests, through: :problem_tests

  scope :of_mission, ->(mission_id) { where(mission_id: mission_id) }
  scope :search_test_with_problem_id, ->(problem_id) {
    with_tests
      .problem_and_test_info
      .where(problems: {id: problem_id})
  }
  scope :with_tests, -> { joins(problem_tests: :test) }
  scope :problem_and_test_info, -> {
    select(
      'problems.*,
      problem_tests.score,
      problem_tests.pierced_level,
      tests.test_name,
      tests.test_command,
      tests.pierced_location_id'
    )
  }

  def pierced_locations
    mission.pierced_locations
  end

  def mission
    @mission = Mission.find_by(id: mission_id) if @mission.nil?
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

  def problem_test_params(label)
    {
      problem: self,
      pierced_level: label
    }
  end

  def new_test(test_name, label, pirced_location_id)
    test = @registered_tests&.find_by(test_name: test_name)
    test = Test.new(test_params(test_name, pirced_location_id)) if test.nil?

    @problem_test = test.problem_tests.build(problem_test_params(label))
    test
  end

  def report_errors
    logger.info problem_errors: errors.full_messages
    "fail to create problem #{errors.full_messages.join(' ')}"
  end
end
