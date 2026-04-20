class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :occupation, optional: true

  has_many :programming_languages, through: :profile_programming_languages
  with_options dependent: :destroy do
    has_many :sns_links
    has_many :profile_programming_languages
  end

  validates :user, uniqueness: true
  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :birthday, presence: true
  validate :birthday_in_the_past
  validates :gender, presence: true
  validates :occupation, presence: true, if: -> { :occupation_id.present? }
  validates :introduction, length: { maximum: 500 }

  enum :gender, { male: 0, female: 1, other: 2 }

  private

  def birthday_in_the_past
    return if birthday.blank?
    errors.add(:birthday, :in_the_past) if birthday >= Time.zone.today
  end
end
