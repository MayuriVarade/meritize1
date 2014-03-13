class AddAwardProgramOptionsToVoteSettings < ActiveRecord::Migration
  def change
  	add_column :vote_settings, :is_autopick_winner, :boolean
  	add_column :vote_settings, :is_admin_reminder, :boolean
  	add_column :vote_settings, :is_allow_vote, :boolean
  end
end
