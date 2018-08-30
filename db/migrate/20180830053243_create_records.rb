class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.string :vin
      t.string :vehicle_nickname
      t.string :maintenance_type
      t.string :current_mileage
      t.string :date
      t.string :shop_name

      t.timestamps
    end
  end
end
