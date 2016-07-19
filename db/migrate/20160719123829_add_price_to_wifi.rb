class AddPriceToWifi < ActiveRecord::Migration
  def change
  	add_column :wifis , :price , :integer
  end
end
