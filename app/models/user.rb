# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  role                   :integer          default("normal"), not null
#  snum                   :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  enum role: %i[normal ta admin super]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :students

  def over_ta?
    %w[ta admin super].include? role
  end

  def ensure_authentication_token
   loop do
      token = SecureRandom.urlsafe_base64(24).tr('lIO0', 'sxyz')
      result = update(token: token)
      break if result
    end
  end

  def delete_authentication_token
    update(token: nil)
  end
end
