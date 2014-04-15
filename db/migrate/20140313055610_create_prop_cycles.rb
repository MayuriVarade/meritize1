class CreatePropCycles < ActiveRecord::Migration
  def change
    create_table :prop_cycles do |t|
      t.date :start_cycle
      t.date :end_cycle
      t.integer :user_id
      t.integer :prop_id

      t.timestamps
    end
  end
end
