class SessionsController < ApplicationController
    helper_method :current_plan
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
      	flash.now[:error] = "We don’t recognize that combination of email address and password. Please try again."
      	@title = "Sign in"
      	render 'new'
      elsif user.status == false 
          flash.now[:error] = "Your account has been deactivated. Please contact the administrator."
          @title = "Sign in"
          render 'new'
     
       elsif user.username == "productadmin"
          sign_in user
          redirect_to user_root_path
       elsif (user.username.nil?) && (user.admin_user_id.nil?)
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
                
           if current_user.role?(:admin)
            ProductManagerLog.create(:user_id =>current_user.id,:admin_user_id => current_user.admin_user_id,:sign_in_time => Time.now,:firstname =>current_user.firstname,:lastname =>current_user.lastname,:fullname => current_user.fullname,:email =>current_user.email,:sign_in_count =>tot_count,:ip_address => request.remote_ip)
           end 

            if count == 1
                redirect_to change_password_path
            elsif (count <=4) # redirect to the dashboard the first few times a user logs in
              redirect_to("/dashboard")
            else
              redirect_to admin_user_path
            end

       elsif user.admin_user.status == false
            flash.now[:error] = "Your account has been deactivated. Please contact your Meritize administrator."
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
         elsif (plan_expiry <= 0) && (current_user.role?(:admin)) && (current_user.plan_type == "free")
           redirect_to plans_path
         elsif (count <=4) # redirect to the dashboard the first few times a user logs in
            redirect_to("/dashboard")
         elsif current_user.role?(:admin)
          redirect_to admin_user_path
         else
          if current_plan.name == "Award"
              redirect_to new_vote_path
          elsif current_plan.name == "Applaud"
              redirect_to new_prop_display_path 
          else
            redirect_to new_prop_display_path 
          end
          # redirect_to user_root_path
         end 
      end
    end
 
   	def destroy
  	  sign_out
      # Changed to signin page. AAD 5/2/14
      # redirect_to root_path
      redirect_to "/signin"
   	end


end
