# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  detail     :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Session < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true
  enum status: { active: true, inactive: false }
end
