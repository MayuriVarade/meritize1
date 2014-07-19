class ResultsController < ApplicationController
  before_filter :authenticate, :only => [:votes, :props,:wows,:prop_wows]
  layout 'profile'	
  def votes
  	if request.post? || params[:result]

      if params[:result][:cycle].present?
         @vote_setting1 = current_user.vote_setting 
         @vote_setting1 = current_user.vote_setting 
         @vote_setting_start = @vote_setting1.start_cycle.to_date rescue nil
         @vote_setting_end = @vote_setting1.end_cycle.to_date rescue nil
         @diff = (@vote_setting_end - @vote_setting_start + 1).round rescue nil
         @vote_setting = VoteCycle.find_by_id(params[:result][:cycle]) rescue nil
         @current_result = Result.find_by_start_cycle_and_end_cycle_and_user_id(@vote_setting.start_cycle,@vote_setting.end_cycle,current_user.id) rescue nil
         @result = VoteCount.where("start_cycle = '#{@vote_setting.start_cycle.to_date}' AND end_cycle ='#{@vote_setting.end_cycle.to_date}' AND vote_count > 0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
         @select_winner_month = (@vote_setting1.end_cycle.to_date - 7) rescue nil
         @select_winner_week = (@vote_setting1.end_cycle.to_date - 3) rescue nil
         @todays_date = Date.today
         @result_other_dept = VoteOtherCount.where("start_cycle = '#{@vote_setting.start_cycle.to_date}' AND end_cycle ='#{@vote_setting.end_cycle.to_date}' AND vote_count > 0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
         @engage_user = EngageUser.where("vote_count > 0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil

      else
        @vote_setting1 = current_user.vote_setting 
        @vote_setting_start = @vote_setting1.start_cycle.to_date rescue nil
        @vote_setting_end = @vote_setting1.end_cycle.to_date rescue nil
        @diff = (@vote_setting_end - @vote_setting_start + 1).round rescue nil

        @select_winner_month = (@vote_setting1.end_cycle.to_date - 7) rescue nil
        @select_winner_week = (@vote_setting1.end_cycle.to_date - 3) rescue nil
        @todays_date = Date.today

        @current_result = Result.find_by_start_cycle_and_end_cycle_and_user_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,current_user.id) rescue nil
        @result = VoteCount.where("start_cycle = '#{@vote_setting1.start_cycle.to_date}' AND end_cycle ='#{@vote_setting1.end_cycle.to_date}' AND vote_count > 0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
        @result_other_dept = VoteOtherCount.where("start_cycle = '#{@vote_setting1.start_cycle.to_date}' AND end_cycle ='#{@vote_setting1.end_cycle.to_date}' AND vote_count >0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
        @engage_user = EngageUser.where("vote_count > 0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
      end

         
  	else
  	  @vote_setting1 = current_user.vote_setting 
      @vote_setting_start = @vote_setting1.start_cycle.to_date rescue nil
      @vote_setting_end = @vote_setting1.end_cycle.to_date rescue nil
      @diff = (@vote_setting_end - @vote_setting_start + 1).round rescue nil

      @select_winner_month = (@vote_setting1.end_cycle.to_date - 7) rescue nil
      @select_winner_week = (@vote_setting1.end_cycle.to_date - 3) rescue nil
      @todays_date = Date.today

  	  @current_result = Result.find_by_start_cycle_and_end_cycle_and_user_id(@vote_setting1.start_cycle,@vote_setting1.end_cycle,current_user.id) rescue nil
  	  @result = VoteCount.where("start_cycle = '#{@vote_setting1.start_cycle.to_date}' AND end_cycle ='#{@vote_setting1.end_cycle.to_date}' AND vote_count > 0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
      @result_other_dept = VoteOtherCount.where("start_cycle = '#{@vote_setting1.start_cycle.to_date}' AND end_cycle ='#{@vote_setting1.end_cycle.to_date}' AND vote_count >0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
      @engage_user = EngageUser.where("vote_count > 0 AND user_id = '#{current_user.id}'").order('vote_count DESC').limit(10) rescue nil
  	end	
  end

  def winner
     if params[:type].present?
        @votecount = VoteOtherCount.find_by_id(params[:id])
        @winner = Result.create(:start_cycle => @votecount.start_cycle,:end_cycle =>@votecount.end_cycle,:voteable_id =>@votecount.voteable_id,:vote_count => @votecount.vote_count,:user_id => current_user.id) rescue nil
        flash[:success] = "Done! The winner has been selected."
        redirect_to votes_results_path   

     else 
      	@votecount = VoteCount.find_by_id(params[:id])
        @winner = Result.create(:start_cycle => @votecount.start_cycle,:end_cycle =>@votecount.end_cycle,:voteable_id =>@votecount.voteable_id,:vote_count => @votecount.vote_count,:user_id => current_user.id) rescue nil
        flash[:success] = "Done! The winner has been selected."
        redirect_to votes_results_path
     end 
  end	

  def props
    if request.post? || params[:result]
         
      if params[:result][:cycle].present?

         @prop_setting = current_user.prop 
         @prop_setting_start = @prop_setting.start_cycle.to_date rescue nil
         @prop_setting_end = @prop_setting.end_cycle.to_date rescue nil
         @diff = (@prop_setting_end - @prop_setting_start + 1).round rescue nil
         @prop_setting1 = PropCycle.find_by_id(params[:result][:cycle]) rescue nil
         @current_result = PropResult.find_by_start_cycle_and_end_cycle_and_user_id(@prop_setting.start_cycle,@prop_setting.end_cycle,current_user.id) rescue nil
         @select_winner_month = (@prop_setting.end_cycle.to_date - 7) rescue nil
         @todays_date = Date.today
         @result = PropCount.where("start_cycle = '#{@prop_setting1.start_cycle.to_date}' AND end_cycle ='#{@prop_setting1.end_cycle.to_date}' AND prop_count >0 AND user_id = '#{current_user.id}'").order('prop_count DESC').limit(10) rescue nil
         @result_by_points = PropCount.where("start_cycle = '#{@prop_setting1.start_cycle.to_date}' AND end_cycle ='#{@prop_setting1.end_cycle.to_date}' AND points > 0 AND user_id = '#{current_user.id}'").order('points DESC').limit(10) rescue nil
      else

          @prop_setting = current_user.prop 
          @prop_setting_start = @prop_setting.start_cycle.to_date rescue nil
          @prop_setting_end = @prop_setting.end_cycle.to_date rescue nil
          @diff = (@prop_setting_end - @prop_setting_start + 1).round rescue nil

          @current_result = PropResult.find_by_start_cycle_and_end_cycle_and_user_id(@prop_setting.start_cycle,@prop_setting.end_cycle,current_user.id) rescue nil
          @select_winner_month = (@prop_setting.end_cycle.to_date - 7) rescue nil
          @todays_date = Date.today
          # @current_result = Result.find_by_start_cycle_and_end_cycle(@vote_setting1.start_cycle,@vote_setting1.end_cycle) rescue nil
          @result = PropCount.where("start_cycle = '#{@prop_setting.start_cycle.to_date}' AND end_cycle ='#{@prop_setting.end_cycle.to_date}' AND prop_count > 0 AND user_id = '#{current_user.id}'").order('prop_count DESC').limit(10) rescue nil
       
          @result_by_points = PropCount.where("start_cycle = '#{@prop_setting.start_cycle.to_date}' AND end_cycle ='#{@prop_setting.end_cycle.to_date}' AND points > 0 AND user_id = '#{current_user.id}'").order('points DESC').limit(10) rescue nil

      end

    else
          @prop_setting = current_user.prop 
          @prop_setting = current_user.prop 
          @prop_setting_start = @prop_setting.start_cycle.to_date rescue nil
          @prop_setting_end = @prop_setting.end_cycle.to_date rescue nil
          @diff = (@prop_setting_end - @prop_setting_start + 1).round rescue nil

          @current_result = PropResult.find_by_start_cycle_and_end_cycle_and_user_id(@prop_setting.start_cycle,@prop_setting.end_cycle,current_user.id) rescue nil
          @select_winner_month = (@prop_setting.end_cycle.to_date - 7) rescue nil
          @todays_date = Date.today 
      # @current_result = Result.find_by_start_cycle_and_end_cycle(@vote_setting1.start_cycle,@vote_setting1.end_cycle) rescue nil
      @result = PropCount.where("start_cycle = '#{@prop_setting.start_cycle.to_date}' AND end_cycle ='#{@prop_setting.end_cycle.to_date}' AND prop_count > 0 AND user_id = '#{current_user.id}'").order('prop_count DESC').limit(10) rescue nil

       @result_by_points = PropCount.where("start_cycle = '#{@prop_setting.start_cycle.to_date}' AND end_cycle ='#{@prop_setting.end_cycle.to_date}' AND points > 0 AND user_id = '#{current_user.id}'").order('points DESC').limit(10) rescue nil
    end 
  end
  def wows
    if current_user.role?(:admin)
      @vote_cycle = VoteCycle.find_all_by_user_id(current_user.id,:order => "id desc").first rescue nil
      @wall_of_winner = Result.find_all_by_user_id(current_user.id,:order => "id desc").first rescue nil
      @previous_winner = Result.where(["id != ? and user_id = ? and user_id is not null",@wall_of_winner.id,current_user.id]) rescue nil
           
        @wall_of_winner_voter = Vote.where("cycle_start_date = '#{@wall_of_winner.start_cycle.to_date}' AND cycle_end_date ='#{@wall_of_winner.end_cycle.to_date}'AND voteable_id = '#{@wall_of_winner.voteable_id}'") rescue nil
       
    else
      @vote_cycle = VoteCycle.find_all_by_user_id(current_user.admin_user.id,:order => "id desc").first
      @wall_of_winner = Result.find_all_by_user_id(current_user.admin_user.id,:order => "id desc").first rescue nil
      @wall_of_winner_voter = Vote.find_all_by_start_cycle_and_end_cycle_and_voteable_id(@vote_cycle.start_cycle,@vote_cycle.end_cycle,@wall_of_winner.voteable_id) rescue nil
      @previous_winner = Result.where(["id != ? and user_id = ? and user_id is not null",@wall_of_winner.id,current_user.admin_user_id]) rescue nil
      @wall_of_winner_voter = Vote.where("cycle_start_date = '#{@wall_of_winner.start_cycle.to_date}' AND cycle_end_date ='#{@wall_of_winner.end_cycle.to_date}'AND voteable_id = '#{@wall_of_winner.voteable_id}'") rescue nil
    end  
  end

  def prop_wows
    if current_user.role?(:admin)
         @prop_setting = current_user.prop
         @prop_cycle = PropCycle.find_all_by_user_id(current_user.id,:order => "id desc").first rescue nil
         @wall_of_winner = PropResult.find_all_by_user_id(current_user.id,:order => "id desc").first rescue nil 
         @previous_winner = PropResult.where(["id != ? and user_id = ? and user_id is not null",@wall_of_winner.id,current_user.id]) rescue nil
         if PropDisplay.where("cycle_start_date = '#{@wall_of_winner.start_cycle.to_date}' AND cycle_end_date ='#{@wall_of_winner.end_cycle.to_date}'AND receiver_id = '#{@wall_of_winner.receiver_id}'").count > 10
          # if winner has received more than 10 props then show by a distinct list of senders
          @wall_of_winner_voter = PropDisplay.where("cycle_start_date = '#{@wall_of_winner.start_cycle.to_date}' AND cycle_end_date ='#{@wall_of_winner.end_cycle.to_date}'AND receiver_id = '#{@wall_of_winner.receiver_id}'").select("DISTINCT ON (sender_id) *").limit(10).order("sender_id desc, created_at desc") rescue nil
        else
          @wall_of_winner_voter = PropDisplay.where("cycle_start_date = '#{@wall_of_winner.start_cycle.to_date}' AND cycle_end_date ='#{@wall_of_winner.end_cycle.to_date}'AND receiver_id = '#{@wall_of_winner.receiver_id}'").limit(10).order("created_at desc") rescue nil
        end
       
    else  
         @prop_setting = current_user.admin_user.prop
          @prop_cycle = PropCycle.find_all_by_user_id(current_user.admin_user.id,:order => "id desc").first rescue nil
          @wall_of_winner = PropResult.find_all_by_user_id(current_user.admin_user.id,:order => "id desc").first rescue nil 
          @previous_winner = PropResult.where(["id != ? and user_id = ? and user_id is not null",@wall_of_winner.id,current_user.admin_user.id]) rescue nil
         if PropDisplay.where("cycle_start_date = '#{@wall_of_winner.start_cycle.to_date}' AND cycle_end_date ='#{@wall_of_winner.end_cycle.to_date}'AND receiver_id = '#{@wall_of_winner.receiver_id}'").count > 10
          # if winner has received more than 10 props then show by a distinct list of senders
          @wall_of_winner_voter = PropDisplay.where("cycle_start_date = '#{@wall_of_winner.start_cycle.to_date}' AND cycle_end_date ='#{@wall_of_winner.end_cycle.to_date}'AND receiver_id = '#{@wall_of_winner.receiver_id}'").select("DISTINCT ON (sender_id) *").limit(10).order("sender_id desc, created_at desc") rescue nil
        else
          @wall_of_winner_voter = PropDisplay.where("cycle_start_date = '#{@wall_of_winner.start_cycle.to_date}' AND cycle_end_date ='#{@wall_of_winner.end_cycle.to_date}'AND receiver_id = '#{@wall_of_winner.receiver_id}'").limit(10).order("created_at desc") rescue nil
        end
    end
     
  end


  def prop_winner
    @propcount = PropCount.find_by_id(params[:id])
    @winner = PropResult.create(:start_cycle => @propcount.start_cycle,:end_cycle =>@propcount.end_cycle,:receiver_id =>@propcount.receiver_id,:prop_count => @propcount.prop_count,:points => @propcount.points,:user_id => current_user.id) rescue nil
    flash[:success] = "Done! The winner has been selected."
    redirect_to props_results_path
  end

  def prop_winner_notify
    @user = User.find_by_id(params[:id])
    PropMailer.prop_winner_notify(@user).deliver
    flash[:success] = "The winner has been notified."
    redirect_to props_results_path
  end

  def vote_winner_notify
    @user = User.find_by_id(params[:id])
    VoteMailer.vote_winner_notify(@user).deliver
    flash[:success] = "The winner has been notified."
    redirect_to votes_results_path
  end

  private
    def authenticate
      deny_access unless signed_in?
    end
end
