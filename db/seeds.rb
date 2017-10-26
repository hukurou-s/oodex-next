# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#
User.create(
  email: 'oodex@stu.eng.kagawa-u.ac.jp',
  password: 'hogehoge',
  password_confirmation: 'hogehoge',
  role: :admin,
  snum: 's00t000'
) if Rails.env == 'development' && User.all.size.zero?

100.times do
  if rand > 0.5
    session = FactoryGirl.create(:session)
  else
    session = FactoryGirl.create(:session, :inactive)
  end

  10.times do
    session.missions.push(Mission.new(
      session_id: session.id,
      name: ['三目並べ', '整列算法'].sample,
      detail: Faker::Lorem.paragraphs(Faker::Number.between(1, 7)).join("\n")
    ))
    session.save!
  end
end
