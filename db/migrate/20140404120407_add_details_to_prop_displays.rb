class AddDetailsToPropDisplays < ActiveRecord::Migration
  def change
  	add_column :prop_displays, :cycle_start_date, :date
  	add_column :prop_displays, :cycle_end_date, :date
  	add_column :prop_displays, :prop_setting_id, :integer
  end
end
