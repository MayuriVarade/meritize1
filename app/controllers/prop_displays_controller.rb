class PropDisplaysController < ApplicationController
   before_filter :authenticate, :only => [:edit, :update,:index,:show,:new]
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
        fullname = adminuser.fullname + adminuser.email
        @searchuser << fullname
       end
       @searchuser
  end

  def create
   # receiver = params[:prop_display][:receiver_id]
   # receiver_id = User.find_by_fullname(receiver).id
   prop_display_params = params[:prop_display][:receiver_id]
   prop_display_split = prop_display_params.split(" ")
   prop_display_fullname = prop_display_split[0] + " " + prop_display_split[1]
   prop_display_email = prop_display_split[2]

       receiver_id = User.where(["fullname LIKE ? and email LIKE ?", "%#{prop_display_fullname}%","%#{prop_display_email}%"])
       receiver_id = receiver_id[0].id

  	@prop_display = PropDisplay.new(params[:prop_display])
    @prop_display.receiver_id = receiver_id
  	if @prop_display.save
      flash[:success] = "Prop for this user successfully submitted."
  		redirect_to :back
  	end  	
  end
  private
     #method for deny access if users try to access the pages without login.
    def authenticate
      deny_access unless signed_in?
    end

end
