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
        @adminusers = User.where(["firstname || lastname || fullname LIKE ? and id !=? and admin_user_id = ? and admin_user_id is not null", "%#{params[:search]}%",current_user.id,current_user.admin_user_id])
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

  # scheduler method for triggering reminder_email1. 
    def self.reminder_email1
       admin_user = User.where("username is null  and admin_user_id is null")
      admin_user.each do |au|
        users = User.where("admin_user_id = ?",au.id)
        users.each do |user|
          @props = user.admin_user.prop
          @prop_reminder1_days = ( @props.start_cycle.to_date + @props.reminder1_days )
            if PropDisplay.where("created_at >= '#{@props.start_cycle.to_date}' AND created_at <='#{@prop_reminder1_days }' AND sender_id = '#{user.id}'").empty?
            puts user.inspect
            prop = au.prop
            PropMailer.prop_mail(user,prop).deliver
          end
        end
      end
    end
  # scheduler method for triggering reminder_email2. 
    def self.reminder_email2
       admin_user = User.where("username is null  and admin_user_id is null")
      admin_user.each do |au|
        users = User.where("admin_user_id = ?",au.id)
        users.each do |user|
          @props = user.admin_user.prop
          @prop_reminder2_days = ( @props.start_cycle.to_date + @props.reminder2_days )
            if PropDisplay.where("created_at >= '#{@props.start_cycle.to_date}' AND created_at <='#{@prop_reminder2_days }' AND sender_id = '#{user.id}'").empty?
            puts user.inspect
            prop = au.prop
            PropMailer.prop_mail_reminder2(user,prop).deliver
          end
        end
      end
    end
    # scheduler method for triggering reminder_email3. 
    def self.reminder_email3
      admin_user = User.where("username is null  and admin_user_id is null")
      admin_user.each do |au|
        users = User.where("admin_user_id = ?",au.id)
        users.each do |user|
          @props = user.admin_user.prop
          @prop_reminder3_days = ( @props.start_cycle.to_date + @props.reminder3_days )
            if PropDisplay.where("created_at >= '#{@props.start_cycle.to_date}' AND created_at <='#{@prop_reminder3_days }' AND sender_id = '#{user.id}'").empty?
            puts user.inspect
            prop = au.prop
            PropMailer.prop_mail_reminder3(user,prop).deliver
          end
        end
      end
    end
  private
     #method for deny access if users try to access the pages without login.
    def authenticate
      deny_access unless signed_in?
    end

end
