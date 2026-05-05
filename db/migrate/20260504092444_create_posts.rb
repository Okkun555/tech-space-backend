class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :content, null: false, comment: '投稿内容'
      t.timestamps
    end
  end
end
