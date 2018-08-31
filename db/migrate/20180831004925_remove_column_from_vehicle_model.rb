class RemoveColumnFromVehicleModel < ActiveRecord::Migration[5.2]
  def change
    remove_column :vehicles, :nickname, :string
  end
end
