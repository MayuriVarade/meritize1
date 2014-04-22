class AddFirstnameToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :firstname, :string
  end
end
