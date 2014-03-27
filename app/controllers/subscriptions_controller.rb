class SubscriptionsController < ApplicationController

   before_filter :authenticate, :only => [:edit, :update,:show,:new,:index]

 layout "profile"

  # Method for Subscription return url
def success
  @subscription = Subscription.new(:user_id => params[:user_id], :token => params[:token], :price => params[:price])
      plan = Plan.find(params[:plan_id])
      @subscription = plan.subscriptions.build
      if params[:PayerID]
      @subscription.user_id = params[:user_id]
      @subscription.price = params[:price]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
      @subscription.email = @subscription.paypal.checkout_details.email
    end
     if @subscription.save_with_payment
       UserMailer.welcome_email(@subscription).deliver
      redirect_to :action => 'show', :id => @subscription.plan_id
    else
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
      redirect_to subscription.paypal.checkout_url(
      return_url: success_url(:plan_id => plan.id,:user_id => current_user.id, :price => plan.price),
      cancel_url: root_url
      )
  
  end

  def history
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

