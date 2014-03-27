class Plan < ActiveRecord::Base
  attr_accessible :name, :price, :user_id, :description1, :description2, :description3,:forusers, :foradmins, :pricing
  belongs_to :user
  has_many :subscriptions
  has_many :payment_notifications
end
