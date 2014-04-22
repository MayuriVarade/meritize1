class AddEmailToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :email, :string
  end
end
