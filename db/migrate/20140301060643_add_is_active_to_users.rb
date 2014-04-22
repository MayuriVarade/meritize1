class AddIsActiveToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :boolean,:default => 'true'
    add_column :users, :fullname, :string
  end
end
