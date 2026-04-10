require 'rails_helper'

RSpec.describe "Api::Auth::Sessions", type: :request do
  describe "POST /api/auth/login" do
    subject { post api_auth_login_path, params: }

    let(:user) { create(:user) }
    let(:email) { user.email }
    let(:password) { 'password123' }
    let(:params) { { session: { email:, password: } } }

    context "有効なパラメータの場合" do
      it 'sessionを設定し、200を返す' do
        subject

        expect(response).to have_http_status(:ok)
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "無効なパラメータの場合" do
      context "メールアドレスが存在しない場合" do
        let(:email) { "invalid-email@email.com" }

        it "401を返す" do
          subject

          expect(response).to have_http_status(:unauthorized)
        end
      end

      context "パスワードが異なる場合" do
        let(:password) { 'invalid-password' }

        it "401を返す" do
          subject

          expect(response). to have_http_status(:unauthorized)
        end
      end
    end
  end
end
