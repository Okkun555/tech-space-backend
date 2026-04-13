FactoryBot.define do
  factory :occupation do
    sequence(:name) { |n| "職種#{n}" }
  end
end
