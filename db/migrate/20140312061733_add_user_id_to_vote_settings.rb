class AddUserIdToVoteSettings < ActiveRecord::Migration
  def change
  	add_column :vote_settings, :user_id, :integer
  end
end
