class MultipleColumnChangesForSeveralModels < ActiveRecord::Migration[5.2]
  def change
    rename_column :records, :vehicle_vin, :vehicle_id
    remove_column :records, :vehicle_nickname, :string
    rename_column :records, :shop_name, :shop_id
    add_column :records, :user_id, :integer
    add_column :shops, :user_id, :integer
    add_column :vehicles, :user_id, :integer
  end
end
