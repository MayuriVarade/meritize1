class SessionsController < ApplicationController
  
    def new
      if signed_in?
        redirect_to("/dashboard")
      else
        @title="Sign in"
      end  
    end
  	def create
      user = User.authenticate(params[:session][:email], params[:session][:password])
      if user.nil? 
      	flash.now[:error] = "Invalid email/password combination."
      	@title = "Sign in"
      	render 'new'
      elsif user.status == false 
        flash.now[:error] = "Your account has been deactivated by your company admin."
        @title = "Sign in"
        render 'new'

      else
         sign_in user
         if params[:remember_me]
            cookies.permanent[:auth_token] = user.auth_token
         else
           cookies[:auth_token] = user.auth_token  
         end
         count = current_user.sign_in_count
         tot_count = count + 1 
         user.update_column(:sign_in_count,tot_count)
         user.update_column(:last_sign_in,Time.now)

         if current_user.role?(:user)
          AdminuserLog.create(:user_id =>current_user.id,:admin_user_id => current_user.admin_user_id,:sign_in_time => Time.now,:firstname =>current_user.firstname,:lastname =>current_user.lastname,:username => current_user.username,:fullname => current_user.fullname,:email =>current_user.email,:sign_in_count =>tot_count,:ip_address => request.remote_ip)
         end 
         if (count == 1) and (current_user.role?(:admin) || current_user.role?(:user))
            redirect_to change_password_path
         else
          redirect_to user_root_path
         end 
      end
    end
 
   	def destroy
  	  sign_out
      redirect_to root_path
   	end


end
