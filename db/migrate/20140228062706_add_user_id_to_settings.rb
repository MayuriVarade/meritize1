class AddUserIdToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :user_id, :integer
    add_column :settings, :core_value_id, :integer
  end
end
