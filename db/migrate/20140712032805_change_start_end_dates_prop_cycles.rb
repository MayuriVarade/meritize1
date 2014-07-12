class ChangeStartEndDatesPropCycles < ActiveRecord::Migration
  def up
  	change_column :prop_cycles, :start_cycle, :date
  	change_column :prop_cycles, :end_cycle, :date
  end

  def down
	change_column :prop_cycles, :start_cycle, :datetime
  	change_column :prop_cycles, :end_cycle, :datetime
  end
end
