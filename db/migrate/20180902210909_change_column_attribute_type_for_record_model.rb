class ChangeColumnAttributeTypeForRecordModel < ActiveRecord::Migration[5.2]
  def change
    change_column :records, :date, :string
  end
end
