class AddSignInCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sign_in_count, :integer,:default => 1
    add_column :users, :last_sign_in,  :datetime
    add_column :users, :last_sign_out, :datetime
  end
end
