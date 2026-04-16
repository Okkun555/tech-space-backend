require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe "validation" do
    describe "#birthday_in_the_past" do
      let(:profile) { build :profile }

      context "生年月日が今日以前の場合" do
        it "有効なデータであること" do
          profile.birthday = Time.zone.today - 1.day
          expect(profile).to be_valid
        end
      end

      context "生年月日が当日の場合" do
        it "無効なデータであること" do
          profile.birthday = Time.zone.today
          expect(profile).not_to be_valid
        end
      end

      context "生年月日が未来日の場合" do
        it "無効なデータであること" do
          profile.birthday = Time.zone.today + 1.day
          expect(profile).not_to be_valid
        end
      end
    end
  end
end
