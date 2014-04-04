class CreatePropCounts < ActiveRecord::Migration
  def change
    create_table :prop_counts do |t|
      t.integer  :receiver
      t.datetime :start_cycle
      t.datetime :end_cycle
      t.integer  :prop_count
      t.integer  :points
      t.timestamps
    end
  end
end
