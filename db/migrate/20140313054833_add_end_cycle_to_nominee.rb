class AddEndCycleToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :end_cycle, :datetime
  end
end
