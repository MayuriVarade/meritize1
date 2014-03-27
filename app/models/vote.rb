class Vote < ActiveRecord::Base
   attr_accessible :voter_id, :voteable_id,:description,:core_values,:cycle_start_date,:cycle_end_date,:vote_setting_id
    belongs_to :voter ,:class_name => 'User'
    belongs_to :voteable ,:class_name => 'User'
    
end
