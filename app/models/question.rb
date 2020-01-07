# frozen_string_literal: true

class Question < ApplicationRecord # rubocop:disable Metrics/ClassLength
  belongs_to :problem
  has_many :question_tests
  has_many :tests, through: :question_tests
  has_many :submit_questions
  has_many :submit, through: :submit_questions

  scope :of_problem, ->(problem_id) { where(problem_id: problem_id) }
  scope :search_tests_with_problem_id, ->(problem_id) {
    with_tests
      .question_and_test_info
      .where(questions: { problem_id: problem_id })
  }

  scope :with_tests, -> { left_joins(question_tests: :test) }
  scope :question_and_test_info, -> {
    select(
      'questions.*,
      question_tests.score,
      question_tests.pierced_level,
      tests.test_name,
      tests.test_command,
      tests.pierced_location_id'
    )
  }

  scope :with_test_and_submit, -> {
    joins(
      question_tests: [test: :test_results]
    )
  }
  scope :question_score_info, -> {
    select(
      'questions.id,
      question_tests.score,
      question_tests.pierced_level,
      test_results.submit_id,
      test_results.status'
    )
  }
  scope :search_with_submit_id, ->(submit_id) {
    where(test_results: { submit_id: submit_id })
  }

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

  def self.calc_score(user_id, question_id)
    scores = {}
    perfect_score = calc_perfect_score(question_id)
    current_score = calc_user_score(user_id, question_id)
    perfect_score.each do |id, p|
      scores[id] = {
        perfect: p,
        current: current_score[id].to_i
      }
    end
    scores
  end

  def self.calc_perfect_score(question_id)
    score = {}
    score_info = QuestionTest.where(question_id: question_id)
    score_info.each do |info|
      score[info.question_id] = score[info.question_id].to_i + info.score
    end
    score
  end

  def self.calc_user_score(user_id, question_id)
    score = {}
    last_submits = Submit.last_question_submit_ids(user_id, question_id)
    score_info = with_test_and_submit
                 .search_with_submit_id(last_submits.values)
                 .question_score_info
    score_info.each do |info|
      question_id = info.id
      score[question_id] = score[question_id].to_i + info.score if info.status == 'SUCCESS'
    end
    score
  end

  def report_errors
    logger.info question_errors: errors.full_messages
    "fail to create question #{errors.full_messages.join(' ')}"
  end
end
