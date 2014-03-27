class AddReminderDaysToVoteSettings < ActiveRecord::Migration
  def change
    add_column :vote_settings, :reminder1_days, :integer
    add_column :vote_settings, :reminder2_days, :integer
    add_column :vote_settings, :reminder3_days, :integer
  end
end
