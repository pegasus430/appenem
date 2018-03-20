class IncreaseOriginsPublicKeySize < ActiveRecord::Migration[5.0]
  def change
    change_column :origins, :public_key, :string, limit: 4096
  end
end
