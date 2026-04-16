FactoryBot.define do
  factory :profile do
    association :user
    association :occupation

    sequence(:name) { |n| "プロフィール#{n}" }
    birthday { Time.zone.today - 20.years }
    gender          { :male }
    introduction    { nil }
  end
end
