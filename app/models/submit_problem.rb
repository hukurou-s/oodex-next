# frozen_string_literal: true

class SubmitProblem < ApplicationRecord
  belongs_to :submit
  belongs_to :problem
end
