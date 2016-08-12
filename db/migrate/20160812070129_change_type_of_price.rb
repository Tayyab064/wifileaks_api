class ChangeTypeOfPrice < ActiveRecord::Migration
  def change
  	change_column :connections, :total_bill, :float , default: 0.0
  	change_column :wifis, :price, :float , default: 0.0
  end
end
