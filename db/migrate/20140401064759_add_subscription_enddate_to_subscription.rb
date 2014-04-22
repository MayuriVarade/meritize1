class AddSubscriptionEnddateToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subscription_enddate, :date
  end
end
