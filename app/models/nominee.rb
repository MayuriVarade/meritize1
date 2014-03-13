class Nominee < ActiveRecord::Base
  attr_accessible :user_id,  :email, :fullname, :role_id

  has_many :users
  accepts_nested_attributes_for :users
  
end
