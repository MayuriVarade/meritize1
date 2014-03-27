class AddFullnameToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :fullname, :string
  end
end
