class SubscriptionsController < ApplicationController

   before_filter :authenticate, :only => [:edit, :update,:show,:new,:index,:history]

 layout "profile"
 require 'will_paginate/array'
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

    if request.post? || params[:vehicle]
     @start_date = params[:vehicle][:start_date].to_s.to_date
     @end_date = params[:vehicle][:end_date].to_s.to_date
     @user = params[:vehicle][:user].to_i
     
         if  @start_date < @end_date 
             if current_user.role?(:admin) 
                @s = SubscriptionHistory.where("created_at >='#{@start_date }' AND updated_at <='#{@end_date }' AND user_id = '#{current_user.id}' ") rescue nil
                @user = AdminuserLog.where("created_at >='#{@start_date}' AND updated_at <='#{@end_date}' AND admin_user_id = '#{current_user.id}' AND sign_in_count >= '1' ").select(:fullname).uniq.length rescue nil
                @price = @s.sum('price') rescue nil
                @sum = (@user)*(@price).to_f rescue nil
              end  
         else
          redirect_to :back, :notice=> "Endate cannot be greater than start date"
        end  

    end 
  end






  def productadmin_history

    if request.post? || params[:vehicle]
     @start_date = params[:vehicle][:start_date].to_s.to_date
     @end_date = params[:vehicle][:end_date].to_s.to_date
     @user = params[:vehicle][:user].to_i
     
         if  @start_date < @end_date 
             
             
                @user1 = User.where("username is null AND admin_user_id is null  ") rescue nil
                @user1.each_with_index do |adminuser,i|
                  i = 0
                  j = i+1
                
                @subs_user = SubscriptionHistory.where("user_id = ?", @user)[j]
                
                @name = @subs_user.fullname rescue nil

                
                @admin = AdminuserLog.where("created_at >='#{@start_date}' AND updated_at <='#{@end_date}' AND admin_user_id = ? AND sign_in_count >= '1'",@user).select(:fullname).uniq.length rescue nil
                @s1 = SubscriptionHistory.where("created_at >='#{@start_date}' AND updated_at <='#{@end_date}' AND user_id = '#{@user}' ") rescue nil   
                
                @price1 = @s1.sum('price') rescue nil
                @sum1 = (@admin)*(@price1).to_f rescue nil

                
              end  
         else
          redirect_to :back, :notice=> "Endate cannot be greater than start date"
        end  

    end 
  end



  private

     def paypal
      PaypalPayment.new(self)
     end
     
    def authenticate
      deny_access unless signed_in?
    end


end

