# frozen_string_literal: true

# == Schema Information
#
# Table name: missions
#
#  id         :integer          not null, primary key
#  session_id :integer          not null
#  name       :string(255)      not null
#  detail     :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mission < ApplicationRecord
  belongs_to :session

  def files

  end
end
