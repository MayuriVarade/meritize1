class AddUserIdToPropCounts < ActiveRecord::Migration
  def change
    add_column :prop_counts, :user_id, :integer
  end
end
