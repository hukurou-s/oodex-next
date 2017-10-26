# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password 'hogehoge'
    password_confirmation 'hogehoge'
    snum "s#{Faker::Number.between(10, 99)}x#{Faker::Number.between(100, 999)}"
  end

  trait :normal

  trait :ta do
    role :ta
  end

  trait :admin do
    role :admin
  end

  trait :super do
    role :super
  end
end
