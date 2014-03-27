class AddReminderDaysToProps < ActiveRecord::Migration
  def change
    add_column :props, :reminder1_days, :integer
    add_column :props, :reminder2_days, :integer
    add_column :props, :reminder3_days, :integer
  end
end
