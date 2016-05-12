class AddDataToConnection < ActiveRecord::Migration
  def change
  	add_column :connections , :data , :float , default: 0.0
  end
end
