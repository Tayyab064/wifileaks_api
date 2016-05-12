class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :user_id
      t.integer :wifi_id
      t.datetime :disconnected_at
      t.timestamps null: false
    end
  end
end
