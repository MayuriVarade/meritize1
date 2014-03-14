class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voter_id
      t.integer :voteable_id
      t.string  :core_values
      t.integer :vote
      t.timestamps
    end
  end
end
