class AddPaypalRecurringProfileTokenToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :paypal_recurring_profile_token, :string
  end
end
