class AddCoreValuesToPropDisplays < ActiveRecord::Migration
  def change
  	add_column :prop_displays, :core_values, :string
  end
end
