class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.references :occupation, foreign_key: true
      t.string :name, null: false, comment: "アカウント名"
      t.date :birthday, null: false, comment: "生年月日"
      t.integer :gender, null: false, comment: "性別(1:男, 2:女, 3その他"
      t.text :introduction, comment: "自己紹介"
      t.timestamps
    end
  end
end
