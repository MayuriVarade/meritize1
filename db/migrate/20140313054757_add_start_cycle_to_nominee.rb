class AddStartCycleToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :start_cycle, :datetime
  end
end
