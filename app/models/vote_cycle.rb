class VoteCycle < ActiveRecord::Base
   attr_accessible :start_cycle, :end_cycle,:user_id,:vote_setting_id,:award_program_name
   belongs_to :vote_setting
   belongs_to :nominee
end
