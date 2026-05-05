class Post < ApplicationRecord
  belongs_to :profile

  validates :profile, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
