FactoryBot.define do
  factory :post do
    association :profile
    sequence(:content)  { |n| "投稿#{n}" }
  end
end
