class ProductManagerLog < ActiveRecord::Base
  attr_accessible :admin_user_id, :email, :firstname, :fullname, :ip_address, :lastname, :sign_in_count, :sign_in_time, :sign_out_time, :user_id
end
