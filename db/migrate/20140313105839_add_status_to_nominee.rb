class AddStatusToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :status, :boolean
  end
end
