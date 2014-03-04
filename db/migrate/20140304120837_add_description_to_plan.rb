class AddDescriptionToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :description1, :string
    add_column :plans, :description2, :string
    add_column :plans, :description3, :string
  end
end
