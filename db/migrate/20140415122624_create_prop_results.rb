class CreatePropResults < ActiveRecord::Migration
  def change
    create_table :prop_results do |t|
      t.integer  :receiver_id
      t.date     :start_cycle
      t.date     :end_cycle
      t.integer  :prop_count
      t.integer  :points
      t.integer  :user_id
      t.timestamps
    end
  end
end
