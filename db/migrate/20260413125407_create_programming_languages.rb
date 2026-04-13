class CreateProgrammingLanguages < ActiveRecord::Migration[8.1]
  def change
    create_table :programming_languages do |t|
      t.string :name, comment: "言語名"
      t.timestamps
    end

    add_index :programming_languages, :name, unique: true
  end
end
