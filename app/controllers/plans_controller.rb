class PlansController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update,:show,:new,:index]
  layout "admin"
  # GET /plans
  # GET /plans.json
  def index
  	
    @plans = Plan.all
    
      @subscription = Subscription.find_by_user_id(current_user.id) rescue nil
      # raise current_user.id.inspect
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }

    end
  end

  private
    def authenticate
      deny_access unless signed_in?
    end

  
end
