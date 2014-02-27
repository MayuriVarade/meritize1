class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def plan_expiry
      @plan_expiry = (current_user.created_at + 14.days)
      @current_date = (Time.now)
      @remaining_days = (@plan_expiry - @current_date).to_i / 1.day
  end	
end
