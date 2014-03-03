class AddIsActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :boolean,:default => 1
    add_column :users, :fullname, :string,:default => 1
  end
end
