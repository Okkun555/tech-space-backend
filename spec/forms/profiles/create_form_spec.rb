require 'rails_helper'

RSpec.describe Profiles::CreateForm do
  let(:user) { create(:user) }

  context "#save!" do
    let(:name) { Faker::Name.name }
    let(:birthday) { Faker::Date.birthday(min_age: 18, max_age: 65) }
    let(:gender) { "male" }
    let(:introduction) { "Introduction" }
    let(:occupation) { create(:occupation) }
    let(:programming_language) { create(:programming_language) }

    let(:attributes) do
      {
        name:,
        birthday:,
        gender:,
        occupation_id: occupation.id,
        introduction:,
        programming_languages: [
          { id: programming_language.id, experience_years: 1 },
        ],
        sns_links: [
          { service_name: 'github', link: 'https://github.com' },
        ]
      }
    end

    subject { described_class.new(user:, attributes:).save! }

    context "正常系" do
      it "Profileを1件・ProfileProgrammingLanguage・SnsLinkを件数分作成する" do
        expect { subject }.to change(Profile, :count).by(1)
                                                     .and change(ProfileProgrammingLanguage, :count).by(1)
                                                     .and change(SnsLink, :count).by(1)
      end
    end
  end
end

