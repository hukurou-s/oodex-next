# frozen_string_literal: true
#
if Rails.env == 'development' && User.all.size.zero?
  User.create(
    email: 'oodex@stu.eng.kagawa-u.ac.jp',
    password: 'hogehoge',
    password_confirmation: 'hogehoge',
    role: :admin,
    snum: 's00t000'
  )
end

100.times do
  session = if rand > 0.5
              FactoryGirl.create(:session)
            else
              FactoryGirl.create(:session, :inactive)
            end

  50.times do
    detail =  Faker::Lorem.paragraphs(Faker::Number.between(1, 7)).join("\n")
    session.missions.push(Mission.new(
                            session_id: session.id,
                            name: %w[三目並べ 整列算法].sample,
                            detail: detail
    ))
    session.save!
  end
end
