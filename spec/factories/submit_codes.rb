# frozen_string_literal: true

FactoryGirl.define do
  factory :submit_code do
    submit_id 1
    file_name 'MyString'
    code 'MyText'
    pierced_location_id 1
  end
end
