FactoryBot.define do
  factory :profile_programming_language do
    association :profile
    association :programming_language
  end
end
