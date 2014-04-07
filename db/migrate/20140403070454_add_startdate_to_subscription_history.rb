class AddStartdateToSubscriptionHistory < ActiveRecord::Migration
  def change
    add_column :subscription_histories, :startdate, :date
  end
end
