FactoryBot.define do
  factory :sns_link do
    association :profile
    sequence(:service_name)  { |n| "sns#{n}" }
    sequence(:link) { |n| "https://example.com/sns/#{n}" }
  end
end
