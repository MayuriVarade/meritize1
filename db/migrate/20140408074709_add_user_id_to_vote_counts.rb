class AddUserIdToVoteCounts < ActiveRecord::Migration
  def change
    add_column :vote_counts, :user_id, :integer
  end
end
