class AddOriginToProviderUidIndex < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, [:uid, :provider]
    add_index :users, [:uid, :provider, :origin_id], unique: true
  end
end
