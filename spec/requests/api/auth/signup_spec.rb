require 'rails_helper'

RSpec.describe "Api::Auth::Signups", type: :request do
  describe "POST /api/auth/signup" do
    subject { post "/api/auth/signup", params: }

    let(:params) do
      { user: { email:, password:, password_confirmation: password } }
    end
    let(:email) { Faker::Internet.email }
    let(:password) { Faker::Internet.password }

    context "有効なパラメータの場合" do
      it "アカウントを新規作成、201を返却する" do
        expect { subject }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
        expect(response.parsed_body["data"]).to eq({
                                             "id" => User.last&.id,
                                             "email" => email,
                                           })
      end
    end

    context "無効なパラメータの場合" do
      context "形式が無効なメールアドレスの場合" do
        let(:email) { "valid-email.com" }

        it "422とエラーメッセージを返す" do
          expect { subject }.to change(User, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body).to eq({
                                              "errors" => {
                                                "email" => ["メールアドレスは不正な値です"]
                                              }
                                             })
        end
      end

      context "文字数が無効なパスワードの場合" do
        let(:password) { "valid" }

        it "422とエラーメッセージを返す" do
          expect { subject }.to change(User, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body).to eq({
                                               "errors" => {
                                                 "password" => ["パスワードは8文字以上で入力してください"]
                                               }
                                             })
        end
      end

      context "パラメータが空文字の場合" do
        let(:email) { "" }
        let(:password) { "" }

        it "422とエラーメッセージを返す" do
          expect { subject }.to change(User, :count).by(0)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.parsed_body).to eq({
                                               "errors" => {
                                                 "email" => ["メールアドレスを入力してください", "メールアドレスは不正な値です"],
                                                 "password" => ["パスワードを入力してください", "パスワードは8文字以上で入力してください"]
                                               }
                                             })
        end
      end
    end
  end
end
