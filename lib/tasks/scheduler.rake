desc "Tasks called by the Heroku scheduler add-on"
task :update_cycle => :environment do
	puts 'Update Cycle was called'
	# this method will trigger every day and check for cycle completion and create new cycle recursively if cycle duration is over

	# SQL statements for testing this
	# update vote_settings set end_cycle = '2014-07-03' where user_id = 2;
	# select user_id, start_cycle, end_cycle from vote_settings order by user_id desc;
	# select * from vote_cycles order by id desc limit 5;
	puts 'Checking vote cycles'
	@vote_cycle = VoteSetting.all
	@vote_cycle.each do |vc|
		if vc.end_cycle.to_date <= Date.today
			vcuserid = vc.user_id
			vcid = vc.id
			puts 'Found cycle to update. User ID: ' + vcuserid.to_s + '. Vote Setting ID: ' + vcid.to_s + '.'
  			VoteCycle.create(:start_cycle => vc.start_cycle,:end_cycle =>vc.end_cycle,:user_id =>vc.user_id,:vote_setting_id => vc.id,:award_program_name =>vc.award_program_name)
    		if vc.award_frequency_type == "Monthly"
    			new_startcycle = vc.start_cycle.to_date + 1.month
        		new_endcycle   = vc.end_cycle.to_date + 1.month
    		elsif vc.award_frequency_type == "Weekly"
       			new_startcycle = vc.start_cycle.to_date + 1.week
	       		new_endcycle   = vc.end_cycle.to_date + 1.week
    		else
       			new_startcycle = vc.start_cycle.to_date + 3.month
       			new_endcycle   = vc.end_cycle.to_date + 3.month
    		end 
			@update_cycle  = vc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
		end
	end

	# SQL statements for testing this
	# select id, user_id, start_cycle, end_cycle, updated_at from props where user_id = 2;
	# select * from prop_displays where admin_user_id = 2 limit 10;
	# update prop_displays set points = 4, type_cycle = 1 where admin_user_id = 2;
	# update props set start_cycle = '6/1/14', end_cycle = '6/30/14', reset_point = 1 where user_id = 2;
	puts 'Checking props cycles'
    @prop_cycle = Prop.all
    @prop_cycle.each do |pc|
	    if pc.reset_point == "2"
		    # Reset points monthly
	        if pc.end_cycle.to_date <= Date.today
   				puts 'Found cycle to update. User ID: ' + pc.user_id.to_s + '. Props Setting ID: ' + pc.id.to_s + '.'
	        	p = PropDisplay.where("type_cycle = ?", "2")
	            p.each do |p|
	            	p.points = 0
	            	p.save
	            end
	            PropCycle.create(:start_cycle => pc.start_cycle,:end_cycle =>pc.end_cycle,:user_id =>pc.user_id,:prop_id => pc.id)   
	            new_startcycle = pc.start_cycle.to_date + 1.month
	            new_endcycle   = pc.end_cycle.to_date + 1.month
	            @update_cycle = pc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
	        end
	    elsif pc.reset_point == "3"
		    # Reset points quarterly
	        if pc.end_cycle.to_date <= Date.today
   				puts 'Found cycle to update. User ID: ' + pc.user_id.to_s + '. Props Setting ID: ' + pc.id.to_s + '.'
	            p = PropDisplay.where("type_cycle = ?", "3")
	            p.each do |p|
	              p.points = 0
	              p.save
	            end
	            PropCycle.create(:start_cycle => pc.start_cycle,:end_cycle =>pc.end_cycle,:user_id =>pc.user_id,:prop_id => pc.id)   
	            new_startcycle = pc.start_cycle.to_date + 3.month
	            new_endcycle   = pc.end_cycle.to_date + 3.month
	            @update_cycle  = pc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
	        end
	    else
		    # Reset points never, reset cycle monthly
	        if pc.end_cycle.to_date <= Date.today
   				puts 'Found cycle to update. User ID: ' + pc.user_id.to_s + '. Props Setting ID: ' + pc.id.to_s + '.'
	            p = PropDisplay.where("type_cycle = ?", "1")
	            PropCycle.create(:start_cycle => pc.start_cycle,:end_cycle =>pc.end_cycle,:user_id =>pc.user_id,:prop_id => pc.id)   
	            new_startcycle = pc.start_cycle.to_date + 1.month
	            new_endcycle   = pc.end_cycle.to_date + 1.month
	            @update_cycle  = pc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
	        end
	    end
	end 

	puts 'Update Cycle completed'
end

task :send_reminders => :environment do
	puts 'Send Reminders was called'

	# IMPORTANT NOTE
	# The logic here assumes that this task is executed only once a day
	# If it is called more than once a day, the same reminder emails will be sent out again & again

	# SQL statements for testing this
	# select user_id, start_cycle, reminder1_days, reminder2_days, reminder3_days from props;
	# select id, email, admin_user_id, is_prop_reminder, is_vote_reminder from users where id = 24;
    # method for sending reminders for props
	admin_user = User.where("username is null  and admin_user_id is null")
	admin_user.each do |au|
		users = User.where("admin_user_id = ?",au.id)
		users.each do |user|
	  		@props = user.admin_user.prop
	  		unless @props.nil?  
      			# send reminder only if user hasn't already submitted a prop in the current cycle
       			# send reminder only if user has checked box in their profile to have reminders sent to them
      			if PropDisplay.where("created_at >= '#{@props.start_cycle.to_date}' AND sender_id = '#{user.id}'").empty? && (user.is_prop_reminder) == true
		    		@prop_reminder1_days = ( @props.start_cycle.to_date + @props.reminder1_days )
		    		@prop_reminder2_days = ( @props.start_cycle.to_date + @props.reminder2_days )
		    		@prop_reminder3_days = ( @props.start_cycle.to_date + @props.reminder3_days )
		    		# send reminder only if admin has elected to send a reminder (reminder_days has to be a non-zero value)
		    		# send reminder if today is the day to send the reminder
		    		if @prop_reminder1_days.to_date == Date.today && @props.reminder1_days > 0
	        			puts 'Sending props reminder email #1 to user id: ' + user.id.to_s #inspect
	        			prop = au.prop
          				PropMailer.prop_mail(user,prop).deliver
	      			end
		    		if @prop_reminder2_days.to_date == Date.today && @props.reminder2_days > 0
	        			puts 'Sending props reminder email #2 to user id: ' + user.id.to_s
	        			prop = au.prop
          				PropMailer.prop_mail_reminder2(user,prop).deliver
	      			end
		    		if @prop_reminder3_days.to_date == Date.today && @props.reminder3_days > 0
	        			puts 'Sending props reminder email #3 to user id: ' + user.id.to_s
	        			prop = au.prop
          				PropMailer.prop_mail_reminder3(user,prop).deliver
	      			end
	    		end
	  		end 
		end
	end

    #PropDisplaysController.reminder_email1  
    #method for sending vote reminder2 for props
    #PropDisplaysController.reminder_email2
    #method for sending vote reminder3 for props
    #PropDisplaysController.reminder_email3

    puts 'Send Reminers completed'
end