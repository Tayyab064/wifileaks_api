class AddAndRenameColumnInConnection < ActiveRecord::Migration
  def change
  	rename_column :connections , :data , :download_data
  	add_column :connections , :upload_data , :float , default: 0.0
  end
end
