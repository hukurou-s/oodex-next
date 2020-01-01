# frozen_string_literal: true

FactoryGirl.define do
  factory :test_result do
    submit_id 1
    test_id 1
    status 'MyString'
    target 'MyString'
    message 'MyText'
  end
end
