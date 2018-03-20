class AddFullAccessToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :full_access, :boolean, null: false, default: false
  end
end
