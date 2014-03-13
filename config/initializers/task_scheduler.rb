require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.in '1d' do
  @vote_cycle = VoteSetting.all
  @vote_cycle.each do |vc|
    if vc.award_frequency_type == "Monthly"
        if vc.end_cycle.to_date >= Date.today
            VoteCycle.create(:start_cycle => vc.start_cycle,:end_cycle =>vc.end_cycle,:user_id =>vc.user_id,:vote_setting_id => vc.id)   
        	new_startcycle = vc.start_cycle.to_date + 1.month
        	new_endcycle   = vc.end_cycle.to_date + 1.month
            @update_cycle = vc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
        end
    elsif vc.award_frequency_type == "Weekly"
         if vc.end_cycle.to_date >= Date.today
            VoteCycle.create(:start_cycle => vc.start_cycle,:end_cycle =>vc.end_cycle,:user_id =>vc.user_id,:vote_setting_id => vc.id)   
        	new_startcycle = vc.start_cycle.to_date + 1.week
        	new_endcycle   = vc.end_cycle.to_date + 1.week
            @update_cycle = vc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
        end 
    else
    	if vc.end_cycle.to_date >= Date.today
            VoteCycle.create(:start_cycle => vc.start_cycle,:end_cycle =>vc.end_cycle,:user_id =>vc.user_id,:vote_setting_id => vc.id)   
        	new_startcycle = vc.start_cycle.to_date + 3.month
        	new_endcycle   = vc.end_cycle.to_date + 3.month
            @update_cycle  = vc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
        end 

    end
   end 
end