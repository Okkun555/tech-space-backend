class CreateOccupations < ActiveRecord::Migration[8.1]
  def change
    create_table :occupations do |t|
      t.string :name, comment: "職業名"
      t.timestamps
    end

    add_index :occupations, :name, unique: true
  end
end
