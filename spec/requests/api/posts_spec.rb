require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  let(:user) { create(:user) }
  let!(:profile) { create(:profile, user: user) }

  describe "POST /api/posts" do
    subject { post api_posts_path, params: }
    let(:content) { "This is my first post!" }

    let(:params) do
      {
        posts: {
          content:
        }
      }
    end

    context "ログイン済みの場合" do
      before do
        login(user)
      end

      context "正常系" do
        context "画像添付がない場合" do
          it "ログイン済みユーザーに紐づく投稿を作成し、200を返す" do
            expect { subject }.to change(Post, :count).by(1)
            expect(response).to have_http_status(:created)
            expect(response.parsed_body["data"]["profile"]["id"]).to eq(profile.id)
          end
        end

        context "画像添付がある場合" do
          let(:image) { fixture_file_upload("png_sample1.png", "image/png") }
          let(:image2) { fixture_file_upload("png_sample2.png", "image/png") }
          let(:params) do
            {
              posts: {
                content:,
                images: [image, image2]
              }
            }
          end

          it "ログイン済みユーザーに紐づく投稿を作成し、200を返す" do
            expect { subject }.to change(Post, :count).by(1)
            expect(response).to have_http_status(:created)
            expect(response.parsed_body["data"]["profile"]["id"]).to eq(profile.id)
            expect(Post.last&.images&.count).to eq(2)
          end
        end
      end

      context "異常系" do
        context "contentが空の場合" do
          let(:content) { "" }

          it "エラーと422を返す" do
            expect { subject }.to change(Post, :count).by(0)
            expect(response).to have_http_status(:unprocessable_entity)
            expect(response.parsed_body["errors"]).to eq([
                                                            {
                                                              "field" => "content",
                                                              "message" => "内容を入力してください"
                                                            }
                                                          ])
          end
        end
      end
    end

    context "未ログインの場合" do
      it "401を返す" do
        expect { subject }.not_to change(Post, :count)
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
