class Subscription < ActiveRecord::Base
  
  attr_accessible :email, :paypal_customer_token, :paypal_payment_token, :plan_id, :price, :user_id, :token,:paypal_recurring_profile_token, :fullname, :name, :subscription_startdate, :subscription_enddate, :updated_at_to_make_mass_assignable, :updated_at
  before_create :set_time_stamps
  before_save :set_time_stamps

  belongs_to :plan
  belongs_to :user
  validates_presence_of :email
  has_many :subscription_histories
  
 def save_with_payment
    
     if valid?
       if paypal_payment_token.present?

        subscription = Subscription.find_by_email(self.email) rescue nil
        if subscription.present?
          (update_with_paypal_payment(subscription)) && (update_user(user))
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


  # def update_with_paypal_payment(subscribe)
  #   response = paypal.make_recurring
  #   # raise self.user_id.inspect
  #   subscribe.update_attributes(:name => self.name,:fullname => self.fullname,:plan_id => self.plan_id,:price => self.price, :user_id => self.user_id, :email => self.email, :paypal_customer_token => self.paypal_customer_token, :paypal_recurring_profile_token => response.profile_id)
  # end


  def update_with_paypal_payment(subscribe) 

   
    response = paypal.make_recurring
    
    op =  subscribe.price
    on = subscribe.name   
    fullname = subscribe.fullname
    user_id = subscribe.user_id
    startdate = subscribe.created_at
    enddate = subscribe.updated_at    
    enddate = DateTime.current
    email = subscribe.email

   @subscription_history = SubscriptionHistory.create(:enddate => enddate,:startdate => startdate,:email => email,:user_id => user_id,:price => op,:subscription_id => subscribe.id,:name => on,:fullname => fullname,:plan_id => plan_id,:paypal_customer_token => paypal_customer_token, :paypal_recurring_profile_token => response.profile_id)
   subscribe.update_attributes(:name => self.name,:fullname => self.fullname,:plan_id => self.plan_id,:price => self.price, :user_id => self.user_id, :email => self.email, :paypal_customer_token => self.paypal_customer_token, :paypal_recurring_profile_token => response.profile_id)
           

 end

  def update_user(user)
  user.update_attributes(:plan_id => self.plan_id)
  end




  def save_with_paypal_payment
    response = paypal.make_recurring
    self.paypal_recurring_profile_token = response.profile_id    
    save!

  end

  def payment_provided?
    paypal_payment_token.present?
  end


 private
  def set_time_stamps
    self.subscription_startdate = DateTime.now
    self.subscription_enddate = Time.now.end_of_month 
  end

  

end

