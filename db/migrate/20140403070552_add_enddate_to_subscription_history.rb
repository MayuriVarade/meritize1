class AddEnddateToSubscriptionHistory < ActiveRecord::Migration
  def change
    add_column :subscription_histories, :enddate, :date
  end
end
