class PropDisplaysController < ApplicationController
    before_filter :authenticate, :only => [:edit, :update,:index,:show,:new]
   layout 'profile'
   include PropDisplaysHelper
  def index
  end

  def new

    @prop = current_user.admin_user.prop rescue nil
    # @prop_winner = PropCount.where("start_cycle = '#{@prop.start_cycle.to_date}' AND end_cycle ='#{@prop.end_cycle.to_date}' AND prop_count > 0 AND user_id = '#{current_user.admin_user_id}'").order('prop_count DESC').first rescue nil
    # @proppoints_winner = PropCount.where("start_cycle = '#{@prop.start_cycle.to_date}' AND end_cycle ='#{@prop.end_cycle.to_date}' AND points > 0 AND user_id = '#{current_user.admin_user_id}'").order('points DESC').first rescue nil
    @prop_cycle = PropCycle.find_all_by_user_id(current_user.admin_user.id,:order => "id desc").first 
    # Changed 6/27/14. Show leader, not winner
    #@winner = PropResult.find_all_by_user_id(current_user.admin_user.id,:order => "id desc").first rescue nil 
    if current_user.admin_user.prop.assign_points
      #@winner = PropCount.where("start_cycle = '#{@prop.start_cycle.to_date}' AND end_cycle ='#{@prop.end_cycle.to_date}' AND points > 0 AND user_id = '#{current_user.admin_user_id}'").order('points DESC').order('prop_count DESC').first rescue nil
      #@winners_leaderboard = PropCount.where("start_cycle = '#{@prop.start_cycle.to_date}' AND end_cycle ='#{@prop.end_cycle.to_date}' AND points > 0 AND user_id = '#{current_user.admin_user_id}'").order('points DESC').order('prop_count DESC').limit(10) rescue nil
      # use this to find leader for curent cycle: ("start_cycle = '#{@prop.start_cycle.to_date}' AND end_cycle ='#{@prop.end_cycle.to_date}' AND points > 0 AND user_id = '#{current_user.admin_user_id}'").order('points DESC').first rescue nil
      @winner = PropCount.select("receiver_id, sum(prop_count) as prop_count, sum(points) as points").where("user_id = '#{current_user.admin_user_id}'").group("receiver_id").order('points DESC').order('prop_count DESC').first rescue nil
      @winners_leaderboard = PropCount.select("receiver_id, sum(prop_count) as prop_count, sum(points) as points").where("user_id = '#{current_user.admin_user_id}'").group("receiver_id").order('points DESC').order('prop_count DESC').limit(10) rescue nil
    else
      @winner = PropCount.select("receiver_id, sum(prop_count) as prop_count, sum(points) as points").where("user_id = '#{current_user.admin_user_id}'").group("receiver_id").order('prop_count DESC').first rescue nil
      @winners_leaderboard = PropCount.select("receiver_id, sum(prop_count) as prop_count, sum(points) as points").where("user_id = '#{current_user.admin_user_id}'").group("receiver_id").order('prop_count DESC').limit(10) rescue nil
    end
    @prop_displays =  PropDisplay.find_all_by_admin_user_id(current_user.admin_user.id)
    if params[:id] == "1" || params[:id].nil?
     # @prop_displays = PropDisplay.find_all_by_admin_user_id(current_user.admin_user.id)
      @prop_displays = PropDisplay.find_all_by_admin_user_id(current_user.admin_user.id,:order => "created_at DESC",:limit=>10) rescue nil
      @prop_displays_count = PropDisplay.find_all_by_admin_user_id(current_user.admin_user.id,:order => "created_at DESC") 
    else
      # @prop_displays = PropDisplay.where("receiver_id = ?",current_user.id)
       @prop_displays = PropDisplay.find_all_by_receiver_id(current_user,:order => "created_at DESC",:limit=>10)
       @prop_displays_count = PropDisplay.find_all_by_receiver_id(current_user,:order => "created_at DESC",:limit=>10)
    end
    @prop_display = PropDisplay.new
     @searchuser ||= [] 
        @adminusers = User.where(["firstname || lastname || fullname LIKE ? and id !=? and admin_user_id = ? and admin_user_id is not null and status = true", "%#{params[:search]}%",current_user.id,current_user.admin_user_id])
        @adminusers.each do |adminuser|
        fullname = adminuser.fullname + "(" + adminuser.email + ")"
        @searchuser << fullname
       end
       @searchuser
      
  end

  def create
   # receiver = params[:prop_display][:receiver_id]
   # receiver_id = User.find_by_fullname(receiver).id
   @prop = current_user.admin_user.prop rescue nil
   prop_display_params = params[:prop_display][:receiver_id]
   prop_display_split = prop_display_params.split(" ") rescue nil
   prop_display_fullname = prop_display_split[0] + " " + prop_display_split[1] rescue nil
   prop_display_email1 = prop_display_split[2]
   prop_display_email = prop_display_email1.gsub(/[()]/, "") rescue nil
       receiver_id = User.where(["fullname LIKE ? and email LIKE ?", "%#{prop_display_fullname}%","%#{prop_display_email}%"]) rescue nil
       receiver_id = receiver_id[0].id rescue nil
        @receiver_id = receiver_id 

    @prop_display = PropDisplay.new(params[:prop_display])
    @prop_display.receiver_id = receiver_id
    
    if prop_display_params.present? && params[:prop_display][:receiver_id].present? && prop_display_email.present? && params[:prop_display][:description].present?
        if receiver_id.present? 
          if @prop_display.save
              prop_count
             if (@prop_display.receiver.is_prop) == true 
                PropMailer.prop_notification_email(@prop_display).deliver
             end 
              flash[:success] = "Your props have been submitted. You rock for giving props!"
              redirect_to :back
          end 
        else
         flash[:notice] = "Sorry, we cannot find that person."
            redirect_to :back 
        end 
    else
           redirect_to :back, :notice=> "Looks like you haven't filled in all the information. Please try again."  
    end

  end


def like_prop
  @prop_display =PropDisplay.find_by_id(params[:id])
    current_user.like!(@prop_display)
    @likes= @prop_display.likes(@prop_display.id)
      @count ||= []
       @likes.each do |like|
       @count << like.count
       end
       @counts = @prop_display.sum_counts(@count)
     respond_to do |format|
     format.js {}
    end
  end


  def like_count
    @prop_display=PropDisplay.find_by_id(params[:id])
     @likes = @prop_display.likes(@prop_display.id) rescue nil
     @likes = @likes.delete_if {|i| i.count == 0 }
     @likes = @likes.delete_if{|i| i.count == 0}
  end


def prop_click_more
    # Click more should really show additional 10 and then 10 additional props after user clicks again and so on.
    # For now hard coded to pulling the top 100 so that the system isn't overburdened
    @prop = current_user.admin_user.prop
    @prop_displays =  PropDisplay.find_all_by_admin_user_id(current_user.admin_user.id)
    if params[:id] == "1" || params[:id].nil?
      @prop_displays = PropDisplay.find_all_by_admin_user_id(current_user.admin_user.id,:order => "created_at DESC", :limit=>100) 
    else
      @prop_displays = PropDisplay.find_all_by_receiver_id(current_user,:order => "created_at DESC", :limit=>100)
    end
end

# These three reminder email methods are no longer used
# Replaced by scheduler.rake
=begin
  # scheduler method for triggering reminder_email1. 
    def self.reminder_email1
       admin_user = User.where("username is null  and admin_user_id is null")
      admin_user.each do |au|

        users = User.where("admin_user_id = ?",au.id)
        users.each do |user|
          @props = user.admin_user.prop
        unless @props.nil?  
          @prop_reminder1_days = ( @props.start_cycle.to_date + @props.reminder1_days )
            if PropDisplay.where("created_at >= '#{@props.start_cycle.to_date}' AND created_at <='#{@prop_reminder1_days }' AND sender_id = '#{user.id}'").empty?
            puts user.inspect
            prop = au.prop
            if (user.is_prop_reminder) == true
              PropMailer.prop_mail(user,prop).deliver
            end  
          end
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
        unless @props.nil?
          @prop_reminder2_days = ( @props.start_cycle.to_date + @props.reminder2_days )
            if PropDisplay.where("created_at >= '#{@props.start_cycle.to_date}' AND created_at <='#{@prop_reminder2_days }' AND sender_id = '#{user.id}'").empty?
            puts user.inspect
            prop = au.prop
            if (user.is_prop_reminder) == true 
              PropMailer.prop_mail_reminder2(user,prop).deliver
            end  
          end
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
          unless @props.nil?  
            @prop_reminder3_days = ( @props.start_cycle.to_date + @props.reminder3_days )
              if PropDisplay.where("created_at >= '#{@props.start_cycle.to_date}' AND created_at <='#{@prop_reminder3_days }' AND sender_id = '#{user.id}'").empty?
              puts user.inspect
              prop = au.prop
              if (user.is_prop_reminder) == true 
                PropMailer.prop_mail_reminder3(user,prop).deliver
              end  
            end
          end  
        end
      end
    end
=end

  private
     #method for deny access if users try to access the pages without login.
    def authenticate
      deny_access unless signed_in?
    end

end
