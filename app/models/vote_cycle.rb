class VoteCycle < ActiveRecord::Base
   attr_accessible :start_cycle, :end_cycle,:user_id,:vote_setting_id
   belongs_to :vote_setting
end
