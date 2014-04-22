class AddFullnameToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :fullname, :string
  end
end
