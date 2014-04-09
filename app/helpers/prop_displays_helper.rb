module PropDisplaysHelper
	def points
	  s = current_user.admin_user.prop.start_point
	  e = current_user.admin_user.prop.end_point
	  p = current_user.admin_user.prop.step_point
	  arr = []
	  (s..e).step(p) do |n|
	  	arr << n
	  end
	  arr
	end

	def reset_type
		current_user.admin_user.prop.reset_point rescue nil
	end

	def custom_time(prop_display)
	   d =  prop_display.created_at.to_date
	   if d == Date.current

	   	 "Today at #{prop_display.created_at.strftime('%I:%M %p')}"
	   elsif (Date.current - d) == 1
	   	 "Yesterday #{prop_display.created_at.strftime('%I:%M %p')}"

	   	else
	   	 "#{time_ago_in_words(prop_display.created_at)} ago"
	   end
	end

     def prop_count
       
     @prop_count = PropCount.where("start_cycle = '#{@prop.start_cycle}' AND end_cycle ='#{@prop.end_cycle}' AND receiver_id = '#{@receiver_id}'")
     @receiver = PropCount.find_by_start_cycle_and_end_cycle_and_receiver_id(@prop.start_cycle,@prop.end_cycle,@receiver_id)
     @count = PropDisplay.where("cycle_start_date = '#{@prop.start_cycle}' AND cycle_end_date ='#{@prop.end_cycle}' AND receiver_id = '#{@receiver_id}'").count
     @points_sum = PropDisplay.where("cycle_start_date = '#{@prop.start_cycle}' AND cycle_end_date ='#{@prop.end_cycle}' AND receiver_id = '#{@receiver_id}'").sum(:points)
     if @prop_count.empty?

       @prop_count = PropCount.create(:receiver_id => @receiver_id ,:start_cycle =>@prop.start_cycle,:end_cycle => @prop.end_cycle,:prop_count => @count,:points =>@points_sum,:user_id => current_user.admin_user.id) 
     else
     	@update_count = PropCount.update(@receiver.id,:receiver_id => @receiver_id ,:start_cycle =>@receiver.start_cycle,:end_cycle => @receiver.end_cycle,:prop_count => @count,:points =>@points_sum,:user_id => current_user.admin_user.id)  

     end	
  end


	    
end
