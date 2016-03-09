class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :mobile_number
      t.string :password_digest
      t.boolean :email_verified, default: false
      t.boolean :number_verified, default: false

      t.timestamps null: false
    end
  end
end
