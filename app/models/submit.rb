# frozen_string_literal: true

class Submit < ApplicationRecord
  has_one :submit_question
  has_one :question, through: :submit_question
  has_many :submit_codes
  has_many :test_results
  belongs_to :user
  belongs_to :mission

  scope :with_result, -> {
    joins(:submit_question)
  }

  # {questionのid: 対応する最大のsubmitのid}
  def self.last_question_submit_ids(user_id, question_id)
    with_result
      .group('submit_questions.question_id')
      .where(user_id: user_id, submit_questions: { question_id: question_id })
      .maximum(:id)
  end
end
