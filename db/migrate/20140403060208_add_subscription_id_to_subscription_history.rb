class AddSubscriptionIdToSubscriptionHistory < ActiveRecord::Migration
  def change
    add_column :subscription_histories, :subscription_id, :integer
  end
end
