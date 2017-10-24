# == Schema Information
#
# Table name: students
#
#  id           :integer          not null, primary key
#  display_name :string(255)      not null
#  user_id      :integer          not null
#  team_id      :integer          not null
#  session_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Student < ApplicationRecord
  belongs_to :user
end
