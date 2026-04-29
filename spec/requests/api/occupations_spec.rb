require 'rails_helper'

RSpec.describe "Api::Occupations", type: :request do
  let(:user) { create(:user) }

  describe "GET /api/occupations" do
    subject { get api_occupations_path }

    let!(:occupation_1) { create(:occupation) }
    let!(:occupation_2) { create(:occupation) }

    context "ログイン済みの場合" do
      before do
        login(user)
      end

      it "職種一覧と200を返す" do
        subject
        expect(response).to have_http_status(:success)
        expect(response.parsed_body["data"]).to contain_exactly(
                                                          {
                                                            "id" => occupation_1.id,
                                                            "name" => occupation_1.name
                                                          },
                                                          {
                                                            "id" => occupation_2.id,
                                                            "name" => occupation_2.name
                                                          }
                                                        )
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
