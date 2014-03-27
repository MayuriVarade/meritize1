class Nominee < ActiveRecord::Base

  attr_accessible :user_id,  :email, :fullname, :role_id, :vote_setting_id, :start_cycle, :end_cycle,:current_user_id, :status

  has_many :users
  accepts_nested_attributes_for :users
  belongs_to :vote_setting  
    validates :user_id, :presence   => true ,:uniqueness => true
    validates :email, :presence => true, :uniqueness => true
end
