require 'rails_helper'

RSpec.describe "Api::ProgrammingLanguages", type: :request do
  let(:user) { create(:user) }

  describe "GET /api/programming_languages" do
    subject { get api_programming_languages_path }

    let!(:programming_language1) { create(:programming_language) }
    let!(:programming_language2) { create(:programming_language) }

    context "ログイン済みの場合" do
      before do
        login(user)
      end

      it "プログラミング言語一覧と200を返す" do
        subject
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body[:data]).to contain_exactly(
                                                 {
                                                   "id" => programming_language1.id,
                                                   "name" => programming_language1.name,
                                                 },
                                                 {
                                                   "id" => programming_language2.id,
                                                   "name" => programming_language2.name,
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
