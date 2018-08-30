class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :address
      t.string :contact_name
      t.integer :telephone_number
      t.string :notes

      t.timestamps
    end
  end
end
