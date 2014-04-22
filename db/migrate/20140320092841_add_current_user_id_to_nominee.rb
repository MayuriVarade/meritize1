class AddCurrentUserIdToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :current_user_id, :integer
  end
end
