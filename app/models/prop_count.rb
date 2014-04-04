class PropCount < ActiveRecord::Base
  attr_accessible :receiver,:start_cycle,:end_cycle,:prop_count,:points
  belongs_to :voteable ,:class_name => 'User'
end
