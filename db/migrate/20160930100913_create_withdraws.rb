class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table :withdraws do |t|
      t.float :amount , default: 0
      t.boolean :transfered  , default: false
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
