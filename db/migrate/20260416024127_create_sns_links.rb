class CreateSnsLinks < ActiveRecord::Migration[8.1]
  def change
    create_table :sns_links do |t|
      t.references :profile, null: false, foreign_key: true, index: { unique: true }
      t.string :service_name, null: false, comment: "サービス名"
      t.string :link, null: false, comment: "リンク"
      t.timestamps
    end
  end
end
