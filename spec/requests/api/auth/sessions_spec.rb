require 'rails_helper'

RSpec.describe "Api::Auth::Sessions", type: :request do
  let(:user) { create(:user) }

  describe "POST /api/auth/login" do
    subject { post api_auth_login_path, params: }

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
          expect(response.parsed_body).to eq({
                                               "code" => "invalid_credentials",
                                               "errors" => [
                                                 {
                                                   "field" => "base",
                                                   "message" => "メールアドレスまたはパスワードが正しくありません",
                                                 }
                                               ]
                                             })
        end
      end

      context "パスワードが異なる場合" do
        let(:password) { 'invalid-password' }

        it "401を返す" do
          subject
          expect(response). to have_http_status(:unauthorized)
          expect(response.parsed_body).to eq({
                                               "code" => "invalid_credentials",
                                               "errors" => [
                                                 {
                                                   "field" => "base",
                                                   "message" => "メールアドレスまたはパスワードが正しくありません",
                                                 }
                                               ]
                                             })
        end
      end
    end
  end

  describe "DELETE /api/auth/logout" do
    subject { delete api_auth_logout_path }

    before do
      post api_auth_login_path, params: {
        session: {
          email: user.email,
          password: "password123"
        }
      }
    end

    it "sessionが削除し、204を返す" do
      subject
      expect(response).to have_http_status(:no_content)
      expect(session[:user_id]).to eq(nil)
    end
  end
end
