class CreateVoteCounts < ActiveRecord::Migration
  def change
    create_table :vote_counts do |t|
      t.integer  :voteable_id
      t.date :start_cycle
      t.date :end_cycle
      t.integer  :vote_count
      t.timestamps
    end
  end
end
