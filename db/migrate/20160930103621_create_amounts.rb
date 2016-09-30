class CreateAmounts < ActiveRecord::Migration
  def change
    create_table :amounts do |t|
      t.float :amount , default: 0
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
