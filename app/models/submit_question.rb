# frozen_string_literal: true

class SubmitQuestion < ApplicationRecord
  belongs_to :submit
  belongs_to :question
end
