class CreatePropCycles < ActiveRecord::Migration
  def change
    create_table :prop_cycles do |t|
      t.datetime :start_cycle
      t.datetime :end_cycle
      t.integer :user_id
      t.integer :prop_id

      t.timestamps
    end
  end
end
