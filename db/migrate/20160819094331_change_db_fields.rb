class ChangeDbFields < ActiveRecord::Migration
  def change
  	add_column :wifis , :avg_speed , :integer
  	add_column :users , :terminated_successfully , :boolean , default: :true
  end
end
