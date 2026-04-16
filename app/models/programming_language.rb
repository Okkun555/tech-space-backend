class ProgrammingLanguage < ApplicationRecord
  has_many :profile_programming_languages, dependent: :destroy
  has_many :profiles, through: :profile_programming_languages

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
end
