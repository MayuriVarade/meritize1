class VotesController < ApplicationController

  layout 'profile'

  def index
  end

  def new
    @votes = Vote.find_by_voter_id(current_user)
    @vote_setting_enddate = current_user.admin_user.vote_setting.end_cycle.to_date
    @votes_last = Vote.find_all_by_voter_id(current_user).last

    @vote_setting = current_user.admin_user.vote_setting
    @setting = current_user.admin_user.setting
    @core_values = @setting.core_values
  	@vote = Vote.new
     @searchuser ||= [] 
        @adminusers = User.where(["firstname || lastname || fullname LIKE ? and id != ? and admin_user_id is not null", "%#{params[:search]}%",current_user.id])
        @adminusers.each do |adminuser|
        fullname = adminuser.fullname + adminuser.email
        @searchuser << fullname
       end
       @searchuser
  end

  def create
   @votes = Vote.find_by_voter_id(current_user)
   @vote_setting = current_user.admin_user.vote_setting.end_cycle.to_date
   @votes_last = Vote.find_all_by_voter_id(current_user).last
   voteable_params = params[:vote][:voteable_id]
   voteable_split = voteable_params.split(" ")
   voteable_fullname = voteable_split[0] + " " + voteable_split[1]
   voteable_email = voteable_split[2]

   voteable = User.where(["fullname LIKE ? and email LIKE ?", "%#{voteable_fullname}%","%#{voteable_email}%"])
   voteable_id = voteable[0].id
   unless @votes.present? && @votes.vote_setting_id.present? && @vote_setting == @votes_last.cycle_end_date.to_date
  	@vote = Vote.new(params[:vote])
    @vote.voteable_id = voteable_id
    	if @vote.save
    		flash[:success] = "Vote for this user successfully submitted."
    		redirect_to :back
    	end 
   else
     Vote.update(@votes_last.id, :voter_id => current_user.id, :core_values => params[:vote][:core_values], :voteable_id =>voteable_id,:description =>params[:vote][:description],:vote_setting_id =>params[:vote][:vote_setting_id],:cycle_end_date => params[:vote][:cycle_end_date],:cycle_start_date => params[:vote][:cycle_start_date])
     flash[:success] = "Vote for this user successfully changed."
     redirect_to :back
   end	

  end
  

end
