require 'rails_helper'

RSpec.describe "Api::Auth::Me", type: :request do
  let(:user) { create(:user) }

  describe "GET /api/auth/me" do
    subject { get api_auth_me_path }

    context "ログイン済みの場合" do
      before do
        login(user)
      end

      context "ログインユーザーに紐づくプロフィールが存在しない場合" do
        it "ユーザー情報と200を返す" do
          subject
          expect(response).to have_http_status(:ok)
          expect(response.parsed_body["data"]).to eq({
                                "id" => user.id,
                                "email" => user.email,
                              })
        end
      end

      context "ログインユーザーに紐づくプロフィールが存在するの場合" do
        let!(:profile) { create(:profile, user: user) }

        it "ユーザー、プロフィール情報と200を返す" do
          subject
          expect(response).to have_http_status(:ok)
          expect(response.parsed_body["data"]).to eq({
            "id" => user.id,
            "email" => user.email,
            "profile" => {
              "id" => profile.id,
              "name" => profile.name,
              "birthday" => profile.birthday.iso8601,
              "gender" => profile.gender,
              "introduction" => profile.introduction,
              "occupation" => {
                "id" => profile.occupation.id,
                "name" => profile.occupation.name,
              },
            }
                                                     })
        end
      end
    end

    context "未ログインの場合" do
      it "401を返す" do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
