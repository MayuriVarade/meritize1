class AddReminderSettingColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_prop, :boolean
    add_column :users, :is_prop_reminder, :boolean
    add_column :users, :is_vote_reminder, :boolean
  end
end
