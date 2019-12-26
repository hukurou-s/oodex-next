# frozen_string_literal: true

class SubmitCode < ApplicationRecord
  belongs_to :submit
  belongs_to :pierced_location
end
