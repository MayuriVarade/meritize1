class AddDescriptionToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :description1, :text
    add_column :plans, :description2, :text
    add_column :plans, :description3, :text
  end
end
