class CreateProfileProgrammingLanguages < ActiveRecord::Migration[8.1]
  def change
    create_table :profile_programming_languages do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :programming_language, null: false, foreign_key: true
      t.timestamps
    end

    add_index :profile_programming_languages,
              [ :profile_id, :programming_language_id ],
              unique: true
  end
end
