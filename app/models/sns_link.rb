class SnsLink < ApplicationRecord
  belongs_to :profile

  validates :service_name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :profile_id }
  validates :link, presence: true
end
