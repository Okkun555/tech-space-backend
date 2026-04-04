require 'rails_helper'

RSpec.describe "Api::Auth::Signups", type: :request do
  describe "POST /api/auth/signup" do
    subject { post "/api/auth/signup", params: }

    let(:params) do
      {
        user: {
          email: "test@email.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    context "有効なパラメータの場合" do
      it "ユーザーが作成される" do
        expect { subject }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end
  end
end
