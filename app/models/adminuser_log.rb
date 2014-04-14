class AdminuserLog < ActiveRecord::Base
   attr_accessible :user_id, :admin_user_id,:sign_in_time,:sign_out_time,:ip_address,:firstname,:lastname,:username,:email,:sign_in_count,:fullname
 
	def self.to_csv
	    CSV.generate do |csv|
	      csv << column_names
	      all.each do |user|
	        csv << user.attributes.values_at(*column_names)
	      end
	    end
	end





 def self.import(file, admin_user_id)
  CSV.foreach(file.path, headers: true) do |row|
    AdminuserLog.create! row.to_hash.merge(admin_user_id: admin_user_id)
  end
end
  
   
end
