FactoryBot.define do
  factory :user do
    name { 'ユーザー' }
    email { 'test1@email.com' }
    password { 'password' }
    squat_update { Time.now }
    benchpress_update { Time.now }
    deadlift_update { Time.now }
    benchpress { 0 }
    squat { 0 }
    deadlift { 0 }
  end
end