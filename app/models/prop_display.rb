class PropDisplay < ActiveRecord::Base
  attr_accessible :description, :points, :receiver_id, :sender_id, :type_cycle
  belongs_to :sender ,:class_name => 'User'
  belongs_to :receiver ,:class_name => 'User'
end
