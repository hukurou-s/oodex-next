# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :mission
  belongs_to :pierced_location
  has_many :problem_tests
  has_many :question_tests
  has_many :problems, through: :problem_tests
  has_many :questions, through: :question_tests
  has_many :test_results

  scope :of_mission, ->(mission_id) { where(mission_id: mission_id) }

  def report_errors
    logger.info test_errors: errors.full_messages
    "fail to create test #{errors.full_messages.join(' ')}"
  end
end
