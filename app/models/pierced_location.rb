# frozen_string_literal: true

class PiercedLocation < ApplicationRecord
  serialize :lines
  belongs_to :mission
  has_many :tests

  scope :of_problem_with_test_info, ->(problem_id) {
    with_test_and_problem
      .search_with_problem_id(problem_id)
      .test_info
  }
  scope :with_test_and_problem, -> { joins(tests: [problem_tests: :problem]) }
  scope :search_with_problem_id, ->(problem_id) { merge(Problem.where(id: problem_id)) }
  scope :test_info, -> {
    select(
      'pierced_locations.lines,
      tests.test_name, tests.test_command,
      problem_tests.score,
      problem_tests.pierced_level'
    )
  }
end
