class PropDisplay < ActiveRecord::Base
  attr_accessible :description, :points, :receiver_id, :sender_id, :type_cycle,:admin_user_id,:cycle_start_date,:cycle_end_date, :prop_setting_id
  belongs_to :sender ,:class_name => 'User'
  belongs_to :receiver ,:class_name => 'User'

 acts_as_likeable

  def likes(id)
    Like.find_all_by_likeable_id(id) rescue nil
  end

  def sum_counts(count)
   count.inject{|sum,x| sum + x }
  end

end
