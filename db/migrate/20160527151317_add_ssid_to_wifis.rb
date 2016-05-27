class AddSsidToWifis < ActiveRecord::Migration
  def change
  	add_column :wifis , :ssid , :string
  end
end
