class CreateWifis < ActiveRecord::Migration
  def change
    create_table :wifis do |t|
      t.float :lat
      t.float :long
      t.string :address
      t.string :name
      t.string :password
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
