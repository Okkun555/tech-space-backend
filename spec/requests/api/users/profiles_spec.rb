require 'rails_helper'

RSpec.describe "Api::Users::Profiles", type: :request do
  let(:user) { create(:user) }
  let(:occupation) { create(:occupation) }

  describe "POST /api/users/profile" do
    subject { post api_users_profile_path, params: }

    let(:name) { Faker::Name.name }
    let(:birthday) { Faker::Date.birthday }
    let(:gender) { "male" }
    let(:introduction) { "よろしくお願いします" }
    let(:params) do
      {
        profile: {
          name:,
          birthday:,
          gender:,
          occupation_id: occupation.id,
          introduction:
        }
      }
    end

    context "ログイン済みの場合" do
      before { login(user) }

      context "正常系" do
        context "経験したプログラミング言語、SNSリンクを未入力の場合" do
          it "プロフィールを作成し、201を返す" do
            expect { subject }.to change(Profile, :count).by(1)
                                                         .and change(ProfileProgrammingLanguage, :count).by(0)
                                                                                                        .and change(SnsLink, :count).by(0)
            expect(response).to have_http_status(:created)
          end
        end

        context "経験したプログラミング言語を入力済みの場合" do
          let(:programming_language_1) { create(:programming_language) }
          let(:programming_language_2) { create(:programming_language) }
          let(:params) do
            {
              profile: {
                name:,
                birthday:,
                gender:,
                occupation_id: occupation.id,
                introduction:,
                programming_languages: [
                  { id: programming_language_1.id, experience_years: 1 },
                  { id: programming_language_2.id, experience_years: 2 }
                ]
              }
            }
          end

          it "プロフィールと経験紐付きを作成し、201を返す" do
            expect { subject }.to change(Profile, :count).by(1)
                                                         .and change(ProfileProgrammingLanguage, :count).by(2)
            expect(response).to have_http_status(:created)
          end
        end

        context "SNSリンクを入力済みの場合" do
          let(:params) do
            {
              profile: {
                name:,
                birthday:,
                gender:,
                occupation_id: occupation.id,
                introduction:,
                sns_links: [
                  { service_name: 'github', link: 'https://github.com' },
                  { service_name: 'twitter', link: 'https://twitter.com' }
                ]
              }
            }
          end

          it "プロフィールと経験紐付きを作成し、201を返す" do
              expect { subject }.to change(Profile, :count).by(1)
                                                         .and change(SnsLink, :count).by(2)
            expect(response).to have_http_status(:created)
          end
        end
      end

      context "異常系" do
        context "プロフィール作成済みの場合" do
          before do
            create(:profile, user:)
          end

          it "422を返す" do
            expect { subject }.not_to change(Profile, :count)
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.parsed_body["errors"]).to eq([
                                                           {
                                                             "field" => "user",
                                                             "message" => "プロフィールは作成済みです"
                                                           }
                                                         ])
          end
        end

        context "パラメータが不正な場合" do
          context "アカウント名が空の場合" do
            let(:name) { "" }

            it "422を返す" do
              expect { subject }.not_to change(Profile, :count)
              expect(response).to have_http_status(:unprocessable_entity)
              expect(response.parsed_body["errors"]).to eq([
                                                             {
                                                               "field" => "name",
                                                               "message" => "アカウント名を入力してください"
                                                             }
                                                           ])
            end
          end
        end
      end
    end

    context "未ログインの場合" do
      it "401を返す" do
        expect { subject }.not_to change(Profile, :count)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
