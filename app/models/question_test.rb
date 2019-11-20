# frozen_string_literal: true

class QuestionTest < ApplicationRecord
  belongs_to :question
  belongs_to :test
  enum pierced_level: %i[L0 L1 L2]
end
