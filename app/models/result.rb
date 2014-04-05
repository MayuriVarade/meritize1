class Result < ActiveRecord::Base
   attr_accessible :start_cycle, :end_cycle, :voteable_id, :vote_count,:user_id
end
