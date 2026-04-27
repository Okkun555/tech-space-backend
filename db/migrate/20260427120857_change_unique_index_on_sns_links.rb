class ChangeUniqueIndexOnSnsLinks < ActiveRecord::Migration[8.1]
  def change
    remove_index :sns_links, :profile_id
    add_index :sns_links, [:profile_id, :service_name], unique: true
  end
end
