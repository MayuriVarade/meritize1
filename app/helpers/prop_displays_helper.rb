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
end
