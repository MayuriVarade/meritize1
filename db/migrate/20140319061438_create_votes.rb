class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voter_id
      t.integer :voteable_id
      t.text    :description
      t.string  :core_values
      t.datetime :cycle_end_date
      t.datetime :cycle_start_date
      t.integer  :vote_setting_id
      t.timestamps
    end
  end
end
