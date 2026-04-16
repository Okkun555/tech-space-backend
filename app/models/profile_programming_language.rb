class ProfileProgrammingLanguage < ApplicationRecord
  belongs_to :profile
  belongs_to :programming_language

  validates :programming_language_id, uniqueness: { scope: :profile_id }
end
