class CreateOrigins < ActiveRecord::Migration[5.0]
  def change
    create_table :origins do |t|
      t.string :name, null: false
      t.string :public_key

      t.index :name, unique: true
    end
  end
end
