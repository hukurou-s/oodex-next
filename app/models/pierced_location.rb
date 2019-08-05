# frozen_string_literal: true

class PiercedLocation < ApplicationRecord
  serialize :lines
  belongs_to :mission
  has_many :tests
end
