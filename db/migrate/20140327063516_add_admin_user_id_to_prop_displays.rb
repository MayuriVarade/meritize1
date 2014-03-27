class AddAdminUserIdToPropDisplays < ActiveRecord::Migration
  def change
    add_column :prop_displays, :admin_user_id, :integer
  end
end
