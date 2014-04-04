class ResultsController < ApplicationController
  def index
  	@vote_setting1 = current_user.admin_user.vote_setting 
  	@result = VoteCount.where("start_cycle = '#{@vote_setting1.start_cycle.to_date}' AND end_cycle ='#{@vote_setting1.end_cycle.to_date}'").order('vote_count DESC').limit(10)
  	
  end
end
