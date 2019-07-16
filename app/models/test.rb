class Test < ApplicationRecord
  belongs_to :mission
  belongs_to :pierced_location
  has_many :problem_tests
  has_many :problems, through: :problem_tests
end
