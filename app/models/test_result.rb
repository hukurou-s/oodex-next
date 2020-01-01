# frozen_string_literal: true

class TestResult < ApplicationRecord
  belongs_to :submit
  belongs_to :test
end
