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
  if rand > 0.5
    FactoryGirl.create(:session)
  else
    FactoryGirl.create(:session, :inactive)
  end
end
