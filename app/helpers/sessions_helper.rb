module SessionsHelper

	def sign_in(user)
	    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
	    current_user = user
	 end
	  
	def current_user=(user)
	  @current_user = user
	end

	def current_user
	  @current_user ||= user_from_remember_token
	end

	def signed_in?
	  !current_user.nil?
	end

	def sign_out
	 if current_user.present?	
		  current_user.update_column(:last_sign_out,Time.now)
		  if current_user.role?(:user)
		  	@adminuserLog = AdminuserLog.find_all_by_user_id(current_user.id).last
		  	unless @adminuserLog.nil?
	          @adminuserLog.update_column(:sign_out_time,Time.now)
	        end  
	    elsif current_user.role?(:admin)
		  	@productmanagerLog = ProductManagerLog.find_all_by_user_id(current_user.id).last
		  	unless @productmanagerLog.nil?
	          @productmanagerLog.update_column(:sign_out_time,Time.now)
	        end 
		  end
	 	  
	  cookies.delete(:remember_token)
	  self.current_user = nil
	 end 
	end
	private

	def user_from_remember_token
	  User.authenticate_with_salt(*remember_token)
	end

	def remember_token
	  cookies.signed[:remember_token] || [nil, nil]
	end

	def deny_access
	redirect_to signin_path, :notice => "Your session has timed out. Please log in to access this page."
	end

end
