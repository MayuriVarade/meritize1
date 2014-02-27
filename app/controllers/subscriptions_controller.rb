class SubscriptionsController < ApplicationController
 
  def index
  	@subscriptions = Subscription.all
    
  	 respond_to do|format|
  	 	format.html
  	 	format.json {remder json: @subscriptions }
  	 end
  	end

  	def new
  	  @subscription = Subscription.new(:user_id => current_user.id, :token => params[:token])
  	  plan = Plan.find(params[:plan_id])
  	  @subscription = plan.subscriptions.build
  	  if params[:PayerID]	
  		@subscription.user_id = params[:user_id]
  		@subscription.paypal_customer_token = params[:PayerID]
  		@subscription.paypal_payment_token = params[:token]  		
  		@subscription.email = @subscription.paypal.checkout_details.email
  	end
  end

  def edit
  	@subscription = current_user.subscription
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save_with_payment
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

def show
	@subscription = Subscription.find(params[:id])
end

# DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end

  def paypal_checkout
  	plan = Plan.find(params[:plan_id])


  	subscription = plan.subscriptions.build
    user = User.find_by_id(params[:user_id])
   # raise user.inspect
  		redirect_to subscription.paypal.checkout_url(
  			return_url: new_subscription_url(:plan_id => plan.id,:user_id => user.id),
  			cancel_url: root_url
  			)
  	end

  	private

  	 def paypal
  	 	PaypalPayment.new(self)
  	 end
  end

