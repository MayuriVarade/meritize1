class PaymentNotificationController < ApplicationController


	protect_from_forgery :except => [:create]

   def create
     PaymentNotification.create!(:params => params, :status => params[:payment_status], :transaction_id => params[:txn_id])
     if params[:payment_status] == 'Complete'
          @subscription = Subscription.find(params[:invoice])
          ## Working
          @subscription.update_attribute(:paid, Time.now)
          ## Not Working
          UserMailer.welcome_email(@subscription).deliver
        end

     render :nothing => true
   end
end
