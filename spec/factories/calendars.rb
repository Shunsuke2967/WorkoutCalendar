FactoryBot.define do
  factory :calendar do
    title { 'トレーニング' }
    memo { 'テストを書く' }
    user
  end
end