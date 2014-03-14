class AddUsernameToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :username, :string
  end
end
