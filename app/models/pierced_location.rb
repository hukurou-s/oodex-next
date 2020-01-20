# frozen_string_literal: true

class PiercedLocation < ApplicationRecord
  serialize :lines
  belongs_to :mission
  has_many :tests
  has_many :submit_codes

  scope :of_problem_with_test_info, ->(problem_id) {
    with_test_and_problem
      .search_with_problem_id(problem_id)
      .problem_test_info
  }
  scope :with_test_and_problem, -> { joins(tests: [problem_tests: :problem]) }
  scope :search_with_problem_id, ->(problem_id) { merge(Problem.where(id: problem_id)) }
  scope :problem_test_info, -> {
    select(
      'pierced_locations.lines,
      pierced_locations.file_name,
      tests.test_name,
      tests.test_command,
      problem_tests.problem_id,
      problem_tests.score,
      problem_tests.pierced_level'
    )
  }

  scope :of_question_with_test_info, ->(question_id) {
    with_test_and_question
      .search_with_question_id(question_id)
      .question_test_info
  }
  scope :with_test_and_question, -> { joins(tests: [question_tests: :question]) }
  scope :search_with_question_id, ->(question_id) { merge(Question.where(id: question_id)) }
  scope :question_test_info, -> {
    select(
      'pierced_locations.lines,
      pierced_locations.file_name,
      tests.test_name,
      tests.test_command,
      question_tests.question_id,
      question_tests.score,
      question_tests.pierced_level'
    )
  }

  scope :with_submit_codes, ->(submit_id) {
    joins(:submit_codes)
      .select(
        'submit_codes.submit_id,
        submit_codes.file_name,
        submit_codes.code,
        pierced_locations.id,
        pierced_locations.lines,
        pierced_locations.location_id'
      )
      .where(submit_codes: { submit_id: submit_id })
      .order('file_name DESC')
      .order('location_id DESC')
  }
end
