class VoteCount < ActiveRecord::Base
   attr_accessible :voteable_id,:start_cycle,:end_cycle,:vote_count
end
