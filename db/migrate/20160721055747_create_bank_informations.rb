class CreateBankInformations < ActiveRecord::Migration
  def change
    create_table :bank_informations do |t|
      t.string :currency
      t.string :country
      t.string :name
      t.string :routing_number
      t.string :account_number
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
