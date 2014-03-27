class AdminuserLog < ActiveRecord::Base
   attr_accessible :user_id, :admin_user_id,:sign_in_time,:sign_out_time,:ip_address,:firstname,:lastname,:username,:email,:sign_in_count,:fullname
   
   
end
