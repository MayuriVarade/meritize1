class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_timezone
  before_filter :session_expiry
  before_filter :update_activity_time
  include SessionsHelper
  
  #Method for trial days for current_user
  def plan_expiry
      @trial_days = TrialDay.first
      @plan_expiry = (current_user.created_at + @trial_days.days.days)
      @current_date = (Time.zone.now)
      @remaining_days = (@plan_expiry - @current_date).to_i / 1.day      
  end

 

  #Method for counting days which is used for validation
  def days_validation
    @start_cycle =  @vote_setting.start_cycle.to_date 
    @end_cycle   =  @vote_setting.end_cycle.to_date
    @days_count  =  (@end_cycle - @start_cycle).round
  end
   

  private
  # this method for allows the user to set time zone according to country.
  def set_timezone
    tz = current_user ? current_user.time_zone : nil
    Time.zone = tz || ActiveSupport::TimeZone["UTC"]
  end	
  def fullname
  "#{firstname} #{lastname}"
  end
   # this method makes the session timeout,if the page remain idle for some amount of time. 
  def session_expiry
    get_session_time_left
    unless @session_time_left > 0
      flash.now[:error] = "Your session has timed out. Please log back in."
      sign_out
       
    end
  end

  def update_activity_time
    session[:expires_at] = 30.seconds.from_now
  end

  private

  def get_session_time_left
    expire_time = session[:expires_at] || Time.now
    @session_time_left = (expire_time - Time.now).to_i
  end





# def current_plan
#   if session[:plan_id]
#     @current_plan ||= Plan.find(session[:plan_id])
#     session[:plan_id] = nil if @current_plan.purchased_at
#   end
  
#   if session[:plan_id].nil?
#     @current_plan = Plan.create!
#     session[:plan_id] ||= @current_plan.id
#   end
#   @current_plan
# end


end
