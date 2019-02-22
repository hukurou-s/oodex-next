class Test < ApplicationRecord
  belongs_to :mission
  belongs_to :pierced_location
  enum role: %i[L0 L1 L2]
end
