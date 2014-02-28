class PlansController < ApplicationController
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


  # def create
  #   @plan = Plan.new(params[:plan])
  #   UserMailer.welcome_email(@plan).deliver
  #   respond_to do |format|
  #     if @plan.save
  #       format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
  #       format.json { render json: @plan, status: :created, location: @plan }
  #     else
  #       format.html { render action: "new" }
  #       format.json { render json: @plan.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  
end
