class PropDisplaysController < ApplicationController
   before_filter :authenticate, :only => [:edit, :update,:index,:show]
 layout 'profile'

  def index
  end

  def new
    @prop = current_user.admin_user.prop
    @prop_displays = PropDisplay.all
    if params[:id] == "1" || params[:id].nil?
     @prop_displays = PropDisplay.all
    else
      @prop_displays = PropDisplay.where("receiver_id = ?",current_user.id)
    end
  	@prop_display = PropDisplay.new
     @searchuser ||= [] 
        @adminusers = User.where(["firstname || lastname || fullname LIKE ? and id != ? and admin_user_id is not null", "%#{params[:search]}%",current_user.id])
        @adminusers.each do |adminuser|
        fullname = adminuser.fullname
        @searchuser << fullname
       end
       @searchuser
  end

  def create
   receiver = params[:prop_display][:receiver_id]
   receiver_id = User.find_by_fullname(receiver).id
  	@prop_display = PropDisplay.new(params[:prop_display])
    @prop_display.receiver_id = receiver_id
  	if @prop_display.save
  		redirect_to :back
  	end  	
  end
  private
     #method for deny access if users try to access the pages without login.
    def authenticate
      deny_access unless signed_in?
    end

end
