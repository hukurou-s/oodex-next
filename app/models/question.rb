class Question < ApplicationRecord
  belongs_to :problem
  has_many :question_tests
  has_many :tests, through: :question_tests
end
