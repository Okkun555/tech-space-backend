require 'rails_helper'

RSpec.describe "Api::Users::Profiles", type: :request do
  let(:user) { create(:user) }
  let(:occupation) { create(:occupation) }

  describe "POST /api/users/:user_id/profile" do
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
        it "プロフィールを作成し、201を返す" do
          expect { subject }.to change(Profile, :count).by(1)
          expect(response).to have_http_status(:created)
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
