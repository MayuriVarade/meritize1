class EngageUser < ActiveRecord::Base
  attr_accessible :voter_id,:start_cycle,:end_cycle,:vote_count,:user_id
  belongs_to :voter ,:class_name => 'User'
end
