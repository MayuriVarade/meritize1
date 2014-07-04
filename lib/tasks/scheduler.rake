desc "Tasks called by the Heroku scheduler add-on"
task :update_cycle => :environment do
	puts 'Update Cycle was called'
	# this method will trigger every day and check for cycle completion and create new cycle recursively if cycle duration is over
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

  puts 'Send Reminers completed'
end