class CreateVoteCycles < ActiveRecord::Migration
  def change
    create_table :vote_cycles do |t|
      t.date :start_cycle
      t.date :end_cycle
      t.integer  :user_id
      t.integer  :vote_setting_id
      t.timestamps
    end
  end
end
