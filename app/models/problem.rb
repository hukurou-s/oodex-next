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

class Problem < ApplicationRecord
  belongs_to :mission
  has_many :problem_tests
  has_many :tests, through: :problem_tests

  def pierced_locations
    mission.pierced_locations
  end

  def mission
    @mission = Mission.find_by(id: mission_id) if @mission.nil?
    @mission
  end
end
