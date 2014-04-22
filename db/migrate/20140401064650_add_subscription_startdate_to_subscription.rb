class AddSubscriptionStartdateToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subscription_startdate, :date
  end
end
