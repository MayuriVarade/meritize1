class PlansController < ApplicationController
  # GET /plans
  # GET /plans.json
  def index
  	
    @plans = Plan.all
      @subscription = Subscription.find_by_user_id(current_user.id)
      # raise current_user.id.inspect
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plans }
    end
  end

  
end
