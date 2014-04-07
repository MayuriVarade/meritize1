class CreateSubscriptionHistories < ActiveRecord::Migration
  def change
    create_table :subscription_histories do |t|
      t.string :email
      t.integer :plan_id
      t.integer :user_id
      t.string :paypal_payment_token
      t.string :paypal_customer_token
      t.string :paypal_recurring_profile_token
      t.string :token
      t.float :price
      t.string :fullname
      t.string :name

      t.timestamps
    end
  end
end
