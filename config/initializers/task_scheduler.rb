require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.in '1d' do

  #method for triggering new cycles,written here for testing purpose. 
  # this method will trigger every day and check for cycle completion and create new cycle recursively if cycle duration for month is over   
  @vote_cycle = VoteSetting.all
  puts @vote_cycle
  @vote_cycle.each do |vc|
    if vc.award_frequency_type == "Monthly"
        if vc.end_cycle.to_date <= Date.today
            VoteCycle.create(:start_cycle => vc.start_cycle,:end_cycle =>vc.end_cycle,:user_id =>vc.user_id,:vote_setting_id => vc.id)   
        	new_startcycle = vc.start_cycle.to_date + 1.month
        	new_endcycle   = vc.end_cycle.to_date + 1.month
            @update_cycle = vc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
        end
    elsif vc.award_frequency_type == "Weekly"
         if vc.end_cycle.to_date <= Date.today
            VoteCycle.create(:start_cycle => vc.start_cycle,:end_cycle =>vc.end_cycle,:user_id =>vc.user_id,:vote_setting_id => vc.id)   
        	new_startcycle = vc.start_cycle.to_date + 1.week
        	new_endcycle   = vc.end_cycle.to_date + 1.week
            @update_cycle = vc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
        end 
    else

    	if vc.end_cycle.to_date <= Date.today
            VoteCycle.create(:start_cycle => vc.start_cycle,:end_cycle =>vc.end_cycle,:user_id =>vc.user_id,:vote_setting_id => vc.id)   

        	new_startcycle = vc.start_cycle.to_date + 3.month
        	new_endcycle   = vc.end_cycle.to_date + 3.month
          @update_cycle  = vc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
        end 
      end
   end 

     @prop_cycle = Prop.all
     

     @prop_cycle.each do |pc|
      if pc.reset_point == "2"
        # raise pc.end_cycle.to_date.inspect
        puts pc.reset_point
          if pc.end_cycle.to_date <= Date.today 
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
        if pc.end_cycle.to_date <= Date.today
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
          if pc.end_cycle.to_date <= Date.today
            p = PropDisplay.where("type_cycle = ?", "1")
            PropCycle.create(:start_cycle => pc.start_cycle,:end_cycle =>pc.end_cycle,:user_id =>pc.user_id,:prop_id => pc.id)   
            new_startcycle = pc.start_cycle.to_date + 1.month
            new_endcycle   = pc.end_cycle.to_date + 1.month
            @update_cycle  = pc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
        end
      end
     end 

end
#method for sending vote reminder1 for props.

 scheduler.in '1d' do

     #method for sending vote reminder1 for props
     PropDisplaysController.reminder_email1  
     #method for sending vote reminder2 for props
     PropDisplaysController.reminder_email2
     #method for sending vote reminder3 for props
     PropDisplaysController.reminder_email3
 end



    #method for sending vote reminder1 for votes.
    scheduler.in '1d' do
      #method for sending vote reminder1 for votes
      VotesController.reminder_email1
      #method for sending vote reminder2 for votes
      VotesController.reminder_email2
      #method for sending vote reminder3 for votes
      VotesController.reminder_email3
    end


    scheduler.in '1d' do     
     #method for sending  reminder email for user
     UsersController.reminder_email
     
end

