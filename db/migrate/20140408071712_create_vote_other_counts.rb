class CreateVoteOtherCounts < ActiveRecord::Migration
  def change
    create_table :vote_other_counts do |t|
      t.integer  :voteable_id
      t.date :start_cycle
      t.date :end_cycle
      t.integer  :vote_count
      t.integer  :user_id
      t.timestamps
    end
  end
end
