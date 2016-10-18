class CreateEnvVars < ActiveRecord::Migration
  def change
    create_table :env_vars do |t|
      t.string :var
      t.string :val
      t.timestamps null: false
    end
  end
end
