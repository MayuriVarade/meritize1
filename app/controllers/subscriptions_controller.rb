class SubscriptionsController < ApplicationController

   before_filter :authenticate, :only => [:edit, :update,:show,:new,:index,:history]

 layout "profile"

  # Method for Subscription return url
def success
  @subscription = Subscription.new(:user_id => params[:user_id], :token => params[:token], :price => params[:price], :fullname => params[:fullname], :name => params[:name], :subscription_startdate => params[:subscription_startdate],:subscription_enddate => params[:subscription_enddate])
  
      plan = Plan.find(params[:plan_id])
      
      
      @subscription = plan.subscriptions.build
      if params[:PayerID]
      @subscription.user_id = params[:user_id]
      @subscription.price = params[:price]
      @subscription.fullname = params[:fullname]
      @subscription.name = params[:name]
      @subscription.subscription_startdate = params[:subscription_startdate]
      @subscription.subscription_enddate = params[:subscription_enddate]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
      @subscription.email = @subscription.paypal.checkout_details.email

    end

     if @subscription.save_with_payment
      @subscription.user.update_column(:plan_type,"premium") rescue nil

       UserMailer.welcome_email(@subscription).deliver
      redirect_to :action => 'show', :id => @subscription.plan_id
    else
      UserMailer.decline_email(@subscription).deliver
      render :new
    end
end


def show
  @subscription = Subscription.find_by_plan_id(params[:id])
  
end

# PUT /subscriptions/1
# PUT /subscriptions/1.json
  
  def update
    @subscription = current_user.subscription
     if @subscription.update_stripe
      redirect_to edit_subscription_path, :success => 'Updated Card.'
    else
      flash.alert = 'Unable to update card.'
      render :edit
    end
  end




# Logic Of Subscribe For Transaction Completion Process

  def paypal_checkout
    plan = Plan.find(params[:plan_id])
    subscription = plan.subscriptions.build
    user = User.find_by_id(params[:user_id])
    user = User.find_by_fullname(params[:fullname])
    user = Plan.find_by_name(params[:name])
    
      redirect_to subscription.paypal.checkout_url(
      return_url: success_url(:plan_id => plan.id,:user_id => current_user.id, :price => plan.price, :fullname => current_user.fullname, :name => plan.name),
      cancel_url: root_url
      )
  
  end

  def history
   
     # @subscriptions = Subscription.all
     @subscriptions = SubscriptionHistory.find(:all,:conditions => ["user_id = ?", current_user.id], :order => 'created_at, id', :limit => 50)
     @task_months = @subscriptions.group_by { |t| t.updated_at.beginning_of_month }
     render :layout=>"profile"
  end



  private

     def paypal
      PaypalPayment.new(self)
     end
     
    def authenticate
      deny_access unless signed_in?
    end


end

