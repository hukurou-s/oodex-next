class Test < ApplicationRecord
  belongs_to :mission
  belongs_to :pierced_location
  has_many :problem_tests, through: :problems
end
