class RemoveAddPlanFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :plan
  end

  def down
    add_column :users, :plan, :string
  end
end
