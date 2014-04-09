module VotesHelper
  #helper method to increment and decrement the vote count.
  def vote_count
     @vote_other = VoteOtherCount.where("start_cycle = '#{@vote_setting1.start_cycle}' AND end_cycle ='#{@vote_setting1.end_cycle}' AND voteable_id = '#{@receiver}'")
    
     @voteable_other = VoteOtherCount.find_by_start_cycle_and_end_cycle_and_voteable_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,@receiver)


     @vote_count = VoteCount.where("start_cycle = '#{@vote_setting1.start_cycle}' AND end_cycle ='#{@vote_setting1.end_cycle}' AND voteable_id = '#{@receiver}'")
    
     @voteable = VoteCount.find_by_start_cycle_and_end_cycle_and_voteable_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,@receiver)
     @count = Vote.where("cycle_start_date = '#{@vote_setting1.start_cycle.to_date}' AND cycle_end_date ='#{@vote_setting1.end_cycle.to_date}' AND voteable_id = '#{@receiver}'").count
    if @vote.voteable.department == @vote.voter.department 
       if @vote_count.empty?
          @voter_count = VoteCount.create(:voteable_id => @receiver ,:start_cycle =>@vote_setting1.start_cycle,:end_cycle => @vote_setting1.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id) 
       else
       	@update_count = VoteCount.update(@voteable.id,:voteable_id => @receiver ,:start_cycle =>@voteable.start_cycle,:end_cycle => @voteable.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id)  
       end
    else
       if @vote_other.empty?
         @voter_count1 = VoteCount.create(:voteable_id => @receiver ,:start_cycle =>@vote_setting1.start_cycle,:end_cycle => @vote_setting1.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id) 
          @voter_count = VoteOtherCount.create(:voteable_id => @receiver ,:start_cycle =>@vote_setting1.start_cycle,:end_cycle => @vote_setting1.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id) 
       else
          @update_count1 = VoteCount.update(@voteable.id,:voteable_id => @receiver ,:start_cycle =>@voteable.start_cycle,:end_cycle => @voteable.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id)  
        @update_count = VoteOtherCount.update(@voteable_other.id,:voteable_id => @receiver ,:start_cycle =>@voteable_other.start_cycle,:end_cycle =>@voteable_other.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id)  
       end
    end 	
  end
  def update_vote_count
     @voterdept = User.find_by_id(params[:vote][:voter_id]).department
     @voteabledept = User.find_by_id(@receiver).department
    if @voterdept == @voteabledept
  	 @count1 = Vote.find_by_cycle_start_date_and_cycle_end_date_and_voter_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,current_user.id)
  	 @voteable1 = VoteCount.find_by_start_cycle_and_end_cycle_and_voteable_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,@count1.voteable_id)
     @update_count1 = @voteable.update_attributes(:voteable_id => @count1.voteable_id ,:start_cycle =>@count1.cycle_start_date,:end_cycle => @count.cycle_end_date,:vote_count => @voteable.vote_count - 1,:user_id => current_user.admin_user.id) rescue nil

     @count = Vote.find_by_cycle_start_date_and_cycle_end_date_and_voter_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,current_user.id)
     @voteable = VoteOtherCount.find_by_start_cycle_and_end_cycle_and_voteable_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,@count.voteable_id)
     @update_count = @voteable.update_attributes(:voteable_id => @count.voteable_id ,:start_cycle =>@count.cycle_start_date,:end_cycle => @count.cycle_end_date,:vote_count => @voteable.vote_count - 1,:user_id => current_user.admin_user.id) rescue nil
     
    else

     @count = Vote.find_by_cycle_start_date_and_cycle_end_date_and_voter_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,current_user.id)
     @voteable = VoteOtherCount.find_by_start_cycle_and_end_cycle_and_voteable_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,@count.voteable_id)
     @update_count = @voteable.update_attributes(:voteable_id => @count.voteable_id ,:start_cycle =>@count.cycle_start_date,:end_cycle => @count.cycle_end_date,:vote_count => @voteable.vote_count - 1,:user_id => current_user.admin_user.id) rescue nil
     
     @count1 = Vote.find_by_cycle_start_date_and_cycle_end_date_and_voter_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,current_user.id)
     @voteable1 = VoteCount.find_by_start_cycle_and_end_cycle_and_voteable_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,@count.voteable_id)
     @update_count1 = @voteable1.update_attributes(:voteable_id => @count1.voteable_id ,:start_cycle =>@count1.cycle_start_date,:end_cycle => @count1.cycle_end_date,:vote_count => @voteable1.vote_count - 1,:user_id => current_user.admin_user.id) 
    end 
  end
   def create_vote_count
     @voterdept = User.find_by_id(params[:vote][:voter_id]).department
     @voteabledept = User.find_by_id(@receiver).department
     @vote_other = VoteOtherCount.where("start_cycle = '#{@vote_setting1.start_cycle}' AND end_cycle ='#{@vote_setting1.end_cycle}' AND voteable_id = '#{@receiver}'")
     @voteable_other = VoteOtherCount.find_by_start_cycle_and_end_cycle_and_voteable_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,@receiver)
     @vote_count = VoteCount.where("start_cycle = '#{@vote_setting1.start_cycle}' AND end_cycle ='#{@vote_setting1.end_cycle}' AND voteable_id = '#{@receiver}'")
     @voteable = VoteCount.find_by_start_cycle_and_end_cycle_and_voteable_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,@receiver)
     @voteable_other = VoteOtherCount.find_by_start_cycle_and_end_cycle_and_voteable_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,@receiver)
     @count = Vote.where("cycle_start_date = '#{@vote_setting1.start_cycle.to_date}' AND cycle_end_date ='#{@vote_setting1.end_cycle.to_date}' AND voteable_id = '#{@receiver}'").count
    if  @voterdept == @voteabledept
       if @vote_count.empty?
          @voter_count = VoteCount.create(:voteable_id => @receiver ,:start_cycle =>@vote_setting1.start_cycle,:end_cycle => @vote_setting1.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id) 
       else
        @update_count = VoteCount.update(@voteable.id,:voteable_id => @receiver ,:start_cycle =>@voteable.start_cycle,:end_cycle => @voteable.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id)  
       end
    else
       if @vote_other.empty?
          @voter_count1 = VoteCount.create(:voteable_id => @receiver ,:start_cycle =>@vote_setting1.start_cycle,:end_cycle => @vote_setting1.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id) 
          @voter_count = VoteOtherCount.create(:voteable_id => @receiver ,:start_cycle =>@vote_setting1.start_cycle,:end_cycle => @vote_setting1.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id) 
       else
          @update_count1 = VoteCount.update(@voteable.id,:voteable_id => @receiver ,:start_cycle =>@voteable.start_cycle,:end_cycle => @voteable.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id)  
          @update_count = VoteOtherCount.update(@voteable_other.id,:voteable_id => @receiver ,:start_cycle =>@voteable_other.start_cycle,:end_cycle => @voteable_other.end_cycle,:vote_count => @count,:user_id => current_user.admin_user.id)  
       end
    end   
  end

end
