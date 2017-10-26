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

FactoryGirl.define do
  factory :mission do
    name { %w[三目並べ 整列算法].sample }
    detail { Faker::Lorem.paragraphs(Faker::Number.between(1, 7)).join("\n") }
  end
end
