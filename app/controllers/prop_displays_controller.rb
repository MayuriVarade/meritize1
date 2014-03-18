class PropDisplaysController < ApplicationController
 layout 'profile'

  def index
  end

  def new
    @prop = current_user.admin_user.prop
    @prop_displays = PropDisplay.all
  	@prop_display = PropDisplay.new
     @searchuser ||= [] 
        @adminusers = User.where(["firstname || lastname || fullname LIKE ? and admin_user_id is not null", "%#{params[:search]}%"])
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

end
