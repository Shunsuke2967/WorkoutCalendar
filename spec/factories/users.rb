FactoryBot.define do
  factory :user do
    name { 'ユーザー' }
    email { 'test1@email.com' }
    password { 'password' }
    benchpress { 0 }
    squat { 0 }
    deadlift { 0 }
  end
end