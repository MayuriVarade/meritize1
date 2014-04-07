class CreatePropCounts < ActiveRecord::Migration
  def change
    create_table :prop_counts do |t|
      t.integer  :receiver_id
      t.date :start_cycle
      t.date :end_cycle
      t.integer  :prop_count
      t.integer  :points
      t.timestamps
    end
  end
end
