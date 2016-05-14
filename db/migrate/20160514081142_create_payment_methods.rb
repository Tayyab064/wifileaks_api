class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.string :card_number
      t.datetime :expiry
      t.string :cvn
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
