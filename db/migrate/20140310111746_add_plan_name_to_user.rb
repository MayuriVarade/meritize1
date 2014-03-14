class AddPlanNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :plan_name, :string
  end
end
