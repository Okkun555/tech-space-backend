class ProfileProgrammingLanguage < ApplicationRecord
  belongs_to :profile
  belongs_to :programming_language

  validates :programming_language_id, uniqueness: { scope: :profile_id }
  validates :experience_years,
            numericality: { greater_than_or_equal_to: 0, only_integer: true },
            allow_nil: true
end
