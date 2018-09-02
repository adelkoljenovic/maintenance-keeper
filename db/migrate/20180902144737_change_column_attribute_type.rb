class ChangeColumnAttributeType < ActiveRecord::Migration[5.2]
  def change
    change_column :shops, :telephone_number, :string
  end
end
