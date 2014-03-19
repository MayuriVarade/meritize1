class VotesController < ApplicationController

  layout 'profile'

  def index
  end

  def new
    @vote_setting = current_user.admin_user.vote_setting
    @setting = current_user.admin_user.setting
    @core_values = @setting.core_values
  	@vote = Vote.new
     @searchuser ||= [] 
        @adminusers = User.where(["firstname || lastname || fullname LIKE ? and id != ? and admin_user_id is not null", "%#{params[:search]}%",current_user.id])
        @adminusers.each do |adminuser|
        fullname = adminuser.fullname
        @searchuser << fullname
       end
       @searchuser
  end

  def create
   @votes = Vote.find_by_voter_id(current_user)
   
   voteable = params[:vote][:voteable_id]
   voteable_id = User.find_by_fullname(voteable).id
   unless @votes.present? && @votes.vote_setting_id.present?
  	@vote = Vote.new(params[:vote])
    @vote.voteable_id = voteable_id
  	if @vote.save
  		flash[:success] = "Vote for this user successfully submitted."
  		redirect_to :back
  	end 
   else
     Vote.update(@votes.id, :voter_id => current_user.id, :core_values => params[:vote][:core_values], :voteable_id =>voteable_id,:description =>params[:vote][:description],:vote_setting_id =>params[:vote][:vote_setting_id])
     flash[:success] = "Vote for this user successfully changed."
     redirect_to :back
   end	

  end
  

end
