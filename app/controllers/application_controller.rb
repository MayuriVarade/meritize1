class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def plan_expiry
      @plan_expiry = (current_user.created_at + 14.days)
      @current_date = (Time.now)
      @remaining_days = (@plan_expiry - @current_date).to_i / 1.day
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
