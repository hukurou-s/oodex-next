FactoryGirl.define do
  factory :session do
    name { "InfoExpr##{Faker::Number.between(1, 100)} " }
    detail { Faker::Lorem.paragraphs(Faker::Number.between(1, 7)).join("\n")}
    start_at Time.now - 300
    end_at Time.now + 300
  end

  trait :closed do
    end_at Time.now - 1
  end

  trait :not_open do
    start_at Time.now + 1
  end

  trait :inactive do
    status :inactive
  end
end
