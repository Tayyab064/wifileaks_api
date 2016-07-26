class AddBillToConnection < ActiveRecord::Migration
  def change
  	add_column :connections , :total_bill , :integer , default: 0
  end
end
