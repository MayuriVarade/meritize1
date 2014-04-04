class ResultsController < ApplicationController
  layout 'profile'	
  def votes
  	if request.post? || params[:result]
  	     @vote_setting1 = VoteCycle.find_by_id(params[:result][:cycle])
  	     @result = VoteCount.where("start_cycle = '#{@vote_setting1.start_cycle.to_date}' AND end_cycle ='#{@vote_setting1.end_cycle.to_date}' AND vote_count >0").order('vote_count DESC').limit(10) rescue nil
  	else
  	  @vote_setting1 = current_user.vote_setting 
  	  @current_result = Result.find_by_start_cycle_and_end_cycle(@vote_setting1.start_cycle,@vote_setting1.end_cycle)
  	  @result = VoteCount.where("start_cycle = '#{@vote_setting1.start_cycle.to_date}' AND end_cycle ='#{@vote_setting1.end_cycle.to_date}' AND vote_count > 0 ").order('vote_count DESC').limit(10) rescue nil
  	end	
  end

  def winner
  	@votecount = VoteCount.find_by_id(params[:id])
    @winner = Result.create(:start_cycle => @votecount.start_cycle,:end_cycle =>@votecount.end_cycle,:voteable_id =>@votecount.id,:vote_count => @votecount.vote_count)
    redirect_to votes_results_path
  end	
end
