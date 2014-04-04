class ResultsController < ApplicationController
  layout 'profile'	
  def votes
  	if request.post? || params[:result]
  	     @vote_setting1 = VoteCycle.find_by_id(params[:result][:cycle])
  	     @result = VoteCount.where("start_cycle = '#{@vote_setting1.start_cycle.to_date}' AND end_cycle ='#{@vote_setting1.end_cycle.to_date}' AND vote_count >0").order('vote_count DESC').limit(10) rescue nil
  	else
      @vote_setting1 = current_user.vote_setting 
  	  @result = VoteCount.where("start_cycle = '#{@vote_setting1.start_cycle.to_date}' AND end_cycle ='#{@vote_setting1.end_cycle.to_date}' AND vote_count > 0 ").order('vote_count DESC').limit(10) rescue nil
  	end	
  end
end
