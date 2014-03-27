class AddDescriptionToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :forusers, :text
    add_column :plans, :foradmins, :text
    add_column :plans, :pricing, :text
  end
end
