class Post < ApplicationRecord
  MAX_IMAGES = 4
  MAX_IMAGE_BYTE_SIZE = 5.megabytes
  ALLOWED_IMAGE_CONTENT_TYPES = %w[image/jpeg image/png image/gif image/webp].freeze

  has_many_attached :images
  belongs_to :profile

  validates :profile, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :images_count_within_limit, :images_size_limit, :image_content_type_allowed

  private

  def images_count_within_limit
    return unless images.attached?
    return if images.size <= MAX_IMAGES

    errors.add(:images, :too_many, count: MAX_IMAGES)
  end

  def images_size_limit
    return unless images.attached?
    return if images.all? { |img| img.byte_size <= MAX_IMAGE_BYTE_SIZE }

    errors.add(:images, :too_large, max: "#{MAX_IMAGE_BYTE_SIZE / 1.megabyte}MB")
  end

  def image_content_type_allowed
    return unless images.attached?
    return if images.all? { |img| ALLOWED_IMAGE_CONTENT_TYPES.include?(img.content_type) }

    errors.add(:images, :invalid_content_type)
  end
end
