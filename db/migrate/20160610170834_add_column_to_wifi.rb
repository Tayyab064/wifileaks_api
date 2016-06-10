class AddColumnToWifi < ActiveRecord::Migration
  def change
  	add_column :wifis , :security_type , :string
  end
end
