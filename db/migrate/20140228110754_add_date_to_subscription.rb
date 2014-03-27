class AddDateToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :date, :date
  end
end
