class SubscriptionHistory < ActiveRecord::Base
  attr_accessible :email, :fullname, :name, :paypal_customer_token, :paypal_payment_token, :paypal_recurring_profile_token, :plan_id, :price, :token, :user_id, :subscription_id, :startdate, :enddate
  belongs_to :subscription


  

end
