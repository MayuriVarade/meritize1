class Nominee < ActiveRecord::Base

  attr_accessible :user_id,  :email, :fullname, :role_id, :vote_setting_id, :start_cycle, :end_cycle, :admin_user_id, :firstname, :lastname

  has_many :users
  accepts_nested_attributes_for :users
  belongs_to :vote_setting  
  has_many :admin_user ,:class_name => 'User'

   validates :email, :presence => true, :uniqueness => true
end
