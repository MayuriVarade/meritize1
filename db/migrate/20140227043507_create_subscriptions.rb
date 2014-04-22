class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email
      t.integer :plan_id
      t.integer :user_id
      t.string :paypal_payment_token
      t.string :paypal_customer_token

      t.timestamps
    end
  end
end
