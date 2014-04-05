class PropCount < ActiveRecord::Base
  attr_accessible :receiver_id,:start_cycle,:end_cycle,:prop_count,:points
  belongs_to :receiver ,:class_name => 'User'
end
