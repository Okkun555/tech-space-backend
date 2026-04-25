class AddExperienceYearsToProfileProgrammingLanguages < ActiveRecord::Migration[8.1]
  def change
    add_column :profile_programming_languages, :experience_years, :integer, null: true
  end
end