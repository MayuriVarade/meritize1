class CreateTrailDays < ActiveRecord::Migration
  def change
    create_table :trail_days do |t|
      t.integer :days

      t.timestamps
    end
  end
end
