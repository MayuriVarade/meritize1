class CreateEngageUsers < ActiveRecord::Migration
  def change
    create_table :engage_users do |t|
      t.integer  :voter_id
      t.date :start_cycle
      t.date :end_cycle
      t.integer  :vote_count
      t.integer  :user_id
      t.timestamps
    end
  end
end
