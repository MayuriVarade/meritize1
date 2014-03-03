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
    else
       sign_in user
       
       count = current_user.sign_in_count
       tot_count = count + 1 
       user.update_column(:sign_in_count,tot_count)
       user.update_column(:last_sign_in,Time.now)
       
       if count == 1 and current_user.role?(:admin)
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
