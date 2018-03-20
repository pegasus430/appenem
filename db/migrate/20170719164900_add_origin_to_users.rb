class AddOriginToUsers < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, :email
    add_reference :users, :origin
    add_index :users, [:origin_id, :email], unique: true
  end
end
