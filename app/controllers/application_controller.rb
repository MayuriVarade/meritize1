class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_timezone
  include SessionsHelper
  #Method for trial days 
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
