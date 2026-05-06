require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validation" do
    describe "#images_count_within_limit" do
      let(:post) { build :post }

      context "添付画像がない場合" do
        it "有効なデータであること" do
          expect(post).to be_valid
        end
      end

      context "添付画像がある場合" do
        let(:image) { fixture_file_upload("png_sample1.png", "image/png") }

        context "画像が4枚以下の場合" do
          before do
            4.times { post.images.attach(image) }
          end

          it "有効なデータであること" do
            expect(post).to be_valid
          end
        end

        context "画像が5枚以上の場合" do
          before do
            5.times { post.images.attach(image) }
          end

          it "無効なデータであること" do
            expect(post).to_not be_valid
          end
        end
      end
    end

    describe "#images_size_limit" do
      let(:post) { build :post }

      context "画像添付がない場合" do
        it "有効なデータであること" do
          expect(post).to be_valid
        end
      end

      context '画像添付がある場合' do
        let(:image) { fixture_file_upload("png_sample1.png", "image/png") }
        let(:image_byte_size) { 5.megabytes }

        before do
          post.images.attach(image)
          post.images.each { |img| allow(img.blob).to receive(:byte_size).and_return(image_byte_size) }
        end

        context "最大の画像サイズが5MB以下である場合" do
          it "有効なデータであること" do
            expect(post).to be_valid
          end
        end

        context "最大の画像サイズがが5MBより大きい場合" do
          let(:image_byte_size) { 6.megabytes }

          it "無効なデータであること" do
            expect(post).not_to be_valid
          end
        end
      end
    end

    describe "#image_content_type_allowed" do
      let(:post) { build :post }

      context '添付画像がない場合' do
        it "有効なデータであること" do
          expect(post).to be_valid
        end
      end

      context "添付画像がある場合" do
        let(:image) { fixture_file_upload("png_sample1.png", "image/png") }

        before do
          post.images.attach(image)
          post.images.each { |img| allow(img.blob).to receive(:content_type).and_return("image/heic") }
        end

        context "許可されていない形式の画像の場合" do
          it "無効なデータであること" do
            expect(post).not_to be_valid
          end
        end
      end
    end
  end
end
