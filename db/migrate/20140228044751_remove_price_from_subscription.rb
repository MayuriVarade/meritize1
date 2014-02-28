class RemovePriceFromSubscription < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :price
  end

  def down
    add_column :subscriptions, :price, :string
  end
end
