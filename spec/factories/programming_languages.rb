FactoryBot.define do
  factory :programming_language do
    sequence(:name) { |n| "言語#{n}" }
  end
end
