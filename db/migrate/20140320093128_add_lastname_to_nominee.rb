class AddLastnameToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :lastname, :string
  end
end
