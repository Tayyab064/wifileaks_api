class UpdateConnection < ActiveRecord::Migration
  def change
  	add_column :connections , :connected_at , :datetime
  	remove_column :connections , :rating
  end
end
