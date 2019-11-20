# frozen_string_literal: true

class ProblemTest < ApplicationRecord
  belongs_to :problem
  belongs_to :test
  enum pierced_level: %i[L0 L1 L2]
end
