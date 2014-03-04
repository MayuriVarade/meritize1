class SubscriptionsController < ApplicationController

   before_filter :authenticate, :only => [:edit, :update,:show,:new,:index]

 layout "admin"

  def index
  	@subscriptions = Subscription.all
    
  	 respond_to do|format|
  	 	format.html
  	 	format.json {remder json: @subscriptions }
  	 end
  	end
    

  # GET /subscriptions/new
  # GET /subscriptions/new.json
  	def new
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
  end


# GET /subscriptions/1/edit
  def edit
  	@subscription = current_user.subscription
  end


# POST /subscriptions
# POST /subscriptions.json
  def create
    @subscription = Subscription.new(params[:subscription])    
    if @subscription.save_with_payment
      
      UserMailer.welcome_email(@subscription).deliver
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end


# GET /subscriptions/1
# GET /subscriptions/1.json
  def show
  	@subscription = Subscription.find(params[:id])
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


# Logic Of Subscribe For Transaction Completion Process

  def paypal_checkout
  	plan = Plan.find(params[:plan_id])    
  	subscription = plan.subscriptions.build
    user = User.find_by_id(params[:user_id])    
  	redirect_to subscription.paypal.checkout_url(
  		return_url: new_subscription_url(:plan_id => plan.id,:user_id => user.id, :price => plan.price),
  		cancel_url: root_url
  		)
  end

  def history
      render :layout=>"admin"
  end



  private

  	 def paypal
  	 	PaypalPayment.new(self)
  	 end
     
    def authenticate
      deny_access unless signed_in?
    end


end

