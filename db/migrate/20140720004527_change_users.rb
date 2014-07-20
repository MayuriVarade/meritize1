class ChangeUsers < ActiveRecord::Migration
  def up
  	change_column :users, :is_prop, :boolean, :default => true
  	change_column :users, :is_prop_reminder, :boolean, :default => true
  	change_column :users, :is_vote_reminder, :boolean, :default => true
  end
end
