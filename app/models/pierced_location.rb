class PiercedLocation < ApplicationRecord
  serialize :lines
  belongs_to :mission
end
