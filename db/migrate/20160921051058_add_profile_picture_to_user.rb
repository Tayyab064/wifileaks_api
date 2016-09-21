class AddProfilePictureToUser < ActiveRecord::Migration
  def change
  	add_column :users , :picture , :text , default: ""
  end
end
