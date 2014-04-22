class AddPlanIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :plan_id,:integer
  	add_column :users, :plan_type,:string
  	add_column :users, :companyname,:string
  	add_column :users, :hear_aboutus,:string
  end
end
