class Subscription < ActiveRecord::Base
  
  attr_accessible :email, :paypal_customer_token, :paypal_payment_token, :plan_id, :price, :user_id, :token
 
  belongs_to :plan
  belongs_to :user
   validates_presence_of :email

 def save_with_payment
    
     if valid?
       if paypal_payment_token.present?
        account = Account.find_by(email: self.email) rescue nil
        if account.present?
          update_with_paypal_payment(account)
        else
          save_with_paypal_payment
        end
       else
        raise paypal_payment_token.inspect
       end
     end
   end


  def paypal
  	PaypalPayment.new(self)
  end

  def update_with_paypal_payment(subscribe)
    response = paypal.make_recurring
    raise self.user_id.inspect
    subscribe.update_attributes(:plan_id => self.plan_id, :user_id => self.user_id, :email => self.email, :paypal_customer_token => self.paypal_customer_token, :paypal_recurring_profile_token => response.profile_id)
  end



  def save_with_paypal_payment
  	response = paypal.make_recurring
  	self.paypal_recurring_profile_token = response.profile_id
  	save!
  end

  def payment_provided?
  	paypal_payment_token.present?
  end

end

