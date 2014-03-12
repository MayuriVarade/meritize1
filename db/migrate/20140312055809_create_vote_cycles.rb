class CreateVoteCycles < ActiveRecord::Migration
  def change
    create_table :vote_cycles do |t|
      t.datetime :start_cycle
      t.datetime :end_cycle
      t.integer  :user_id
      t.integer  :vote_setting_id
      t.timestamps
    end
  end
end
