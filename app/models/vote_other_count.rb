class VoteOtherCount < ActiveRecord::Base
   attr_accessible :voteable_id, :start_cycle, :end_cycle, :vote_count, :user_id
   belongs_to :voteable ,:class_name => 'User'
end
