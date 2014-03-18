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
		current_user.admin_user.prop.reset_point
	end

	def ankit(prop_display)
	   d =  prop_display.created_at.to_date
	   if d == Date.today
	   	 "Today at #{prop_display.created_at.strftime('%r')}"
	   elsif (Date.today - d) == 1
	   	 "Yesterday #{prop_display.created_at.strftime('%r')}"
	   	else
	   	 "#{time_ago_in_words(prop_display.created_at)} ago"
	   end
	end
end
