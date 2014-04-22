class AddAdminUserIdToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :admin_user_id, :integer
  end
end
