class Plan < ActiveRecord::Base
  attr_accessible :name, :price, :user_id
  belongs_to :user
  has_many :subscriptions
end
