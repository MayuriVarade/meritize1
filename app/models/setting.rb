class Setting < ActiveRecord::Base
  attr_accessible :company_name, :description, :website_address,:user_id
  belongs_to :user
end
