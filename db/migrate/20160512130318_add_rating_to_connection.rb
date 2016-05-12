class AddRatingToConnection < ActiveRecord::Migration
  def change
  	add_column :connections , :rating , :integer , default: 0
  end
end
