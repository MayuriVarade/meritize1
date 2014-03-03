class AddTotalAmountToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :total_amount, :string
  end
end
