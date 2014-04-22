class CreateTrialDays < ActiveRecord::Migration
  def change
    create_table :trial_days do |t|
      t.integer :days

      t.timestamps
    end
  end
end
