class PropCycle < ActiveRecord::Base
  attr_accessible :end_cycle, :prop_id, :start_cycle, :user_id
end
