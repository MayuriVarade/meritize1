module VotesHelper
  #helper method to increment and decrement the vote count.
  def vote_count

     @vote_count = VoteCount.where("start_cycle = '#{@vote_setting1.start_cycle.to_date}' AND end_cycle ='#{@vote_setting1.end_cycle.to_date}' AND voteable_id = '#{@receiver}'")
    
     @voteable = VoteCount.find_by_start_cycle_and_end_cycle_and_voteable_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,@receiver)
     @count = Vote.where("cycle_start_date = '#{@vote_setting1.start_cycle.to_date}' AND cycle_end_date ='#{@vote_setting1.end_cycle.to_date}' AND voteable_id = '#{@receiver}'").count

     if @vote_count.empty?
        @voter_count = VoteCount.create(:voteable_id => @receiver ,:start_cycle =>@vote_setting1.start_cycle,:end_cycle => @vote_setting1.end_cycle,:vote_count => @count) 
     else
     	@update_count = VoteCount.update(@voteable.id,:voteable_id => @receiver ,:start_cycle =>@voteable.start_cycle,:end_cycle => @voteable.end_cycle,:vote_count => @count)  
     end	
  end
  def update_vote_count
  	 @count = Vote.find_by_cycle_start_date_and_cycle_end_date_and_voter_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,current_user.id)
  	 @voteable = VoteCount.find_by_start_cycle_and_end_cycle_and_voteable_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,@count.voteable_id)
      
     @update_count = @voteable.update_attributes(:voteable_id => @count.voteable_id ,:start_cycle =>@count.cycle_start_date,:end_cycle => @count.cycle_end_date,:vote_count => @voteable.vote_count - 1)  
  end

end
