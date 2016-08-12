class DelAddPriceFields < ActiveRecord::Migration
  def change
  	remove_column :connections, :total_bill, :float , default: 0.0
  	remove_column :wifis, :price, :float , default: 0.0

  	add_column :connections, :total_bill, :float , default: 0.0
  	add_column :wifis, :price, :float , default: 0.0
  end
end
