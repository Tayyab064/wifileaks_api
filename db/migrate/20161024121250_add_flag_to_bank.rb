class AddFlagToBank < ActiveRecord::Migration
  def change
  	add_column :bank_informations , :flag , :string , default: ''
  end
end
