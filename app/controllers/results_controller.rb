class ResultsController < ApplicationController
  layout 'profile'	
  def votes
  	if request.post? || params[:result]
         @vote_setting1 = current_user.vote_setting 
  	     @vote_setting = VoteCycle.find_by_id(params[:result][:cycle])
         @current_result = Result.find_by_start_cycle_and_end_cycle(@vote_setting.start_cycle,@vote_setting.end_cycle) rescue nil
  	     @result = VoteCount.where("start_cycle = '#{@vote_setting.start_cycle.to_date}' AND end_cycle ='#{@vote_setting.end_cycle.to_date}' AND vote_count > 0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
         @result_other_dept = VoteOtherCount.where("start_cycle = '#{@vote_setting.start_cycle.to_date}' AND end_cycle ='#{@vote_setting.end_cycle.to_date}' AND vote_count > 0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
         raise @result_other_dept.inspect
  	else
  	  @vote_setting1 = current_user.vote_setting 
  	  @current_result = Result.find_by_start_cycle_and_end_cycle(@vote_setting1.start_cycle,@vote_setting1.end_cycle) rescue nil
  	  @result = VoteCount.where("start_cycle = '#{@vote_setting1.start_cycle.to_date}' AND end_cycle ='#{@vote_setting1.end_cycle.to_date}' AND vote_count > 0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
       @result_other_dept = VoteOtherCount.where("start_cycle = '#{@vote_setting.start_cycle.to_date}' AND end_cycle ='#{@vote_setting.end_cycle.to_date}' AND vote_count >0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
        raise @result_other_dept.inspect
  	end	
  end

  def winner
  	@votecount = VoteCount.find_by_id(params[:id])
    @winner = Result.create(:start_cycle => @votecount.start_cycle,:end_cycle =>@votecount.end_cycle,:voteable_id =>@votecount.voteable_id,:vote_count => @votecount.vote_count,:user_id => current_user.id) rescue nil
    redirect_to votes_results_path
  end	

  def props
    if request.post? || params[:result]
         @prop_setting = current_user.prop 
         @prop_setting1 = PropCycle.find_by_id(params[:result][:cycle])
         @result = PropCount.where("start_cycle = '#{@prop_setting1.start_cycle.to_date}' AND end_cycle ='#{@prop_setting1.end_cycle.to_date}' AND prop_count >0").order('prop_count DESC').limit(10) rescue nil

         @result_by_points = PropCount.where("start_cycle = '#{@prop_setting1.start_cycle.to_date}' AND end_cycle ='#{@prop_setting1.end_cycle.to_date}' AND points > 0 AND user_id = '#{current_user.id}'").order('points DESC').limit(10) rescue nil
    else
      @prop_setting = current_user.prop 
      # @current_result = Result.find_by_start_cycle_and_end_cycle(@vote_setting1.start_cycle,@vote_setting1.end_cycle) rescue nil
      @result = PropCount.where("start_cycle = '#{@prop_setting.start_cycle.to_date}' AND end_cycle ='#{@prop_setting.end_cycle.to_date}' AND prop_count > 0 AND user_id = '#{current_user.id}'").order('prop_count DESC').limit(10) rescue nil

       @result_by_points = PropCount.where("start_cycle = '#{@prop_setting.start_cycle.to_date}' AND end_cycle ='#{@prop_setting.end_cycle.to_date}' AND points > 0 AND user_id = '#{current_user.id}'").order('points DESC').limit(10) rescue nil
    end 
  end
end
