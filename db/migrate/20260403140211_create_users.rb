class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, comment: 'メールアドレス'
      t.string :password, null: false, comment: 'パスワード'

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
