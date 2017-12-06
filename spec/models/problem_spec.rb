# frozen_string_literal: true

# == Schema Information
#
# Table name: problems
#
#  id         :integer          not null, primary key
#  mission_id :integer          not null
#  name       :string(255)      not null
#  detail     :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Problem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
