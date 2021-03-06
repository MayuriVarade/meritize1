 class PlansController < ApplicationController
   before_filter :authenticate, :only => [:edit, :update,:index,:show,:new]
   layout "profile"
  # GET /plans
  # GET /plans.json
  def index
  	
    @plans = Plan.all
    @plan_expiry = plan_expiry 
    @subscription = Subscription.find_by_user_id(current_user) 
      # raise current_user.id.inspect
    respond_to do |format|
    format.html # index.html.erb
    format.json { render json: @plans }

    end
  end

 def show
    @plan = Plan.find(params[:id])
        
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plan }

    end
  end

  # GET /plans/new
  # GET /plans/new.json
  def new
    @plan = Plan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plan }
    end
  end

  # GET /plans/1/edit
  def edit
    @plan = Plan.find(params[:id])
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(params[:plan])

    respond_to do |format|
      if @plan.save
        format.html { redirect_to plans_path, notice: 'Plan was successfully created.' }
        format.json { render json: @plan, status: :created, location: @plan }
      else
        format.html { render action: "new" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plans/1
  # PUT /plans/1.json
  def update
    @plan = Plan.find(params[:id])
   
    respond_to do |format|
      if @plan.update_attributes(params[:plan])

        format.html { redirect_to plans_path, notice: 'Plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to plans_url }
      format.json { head :no_content }
    end
  end

  private
    def authenticate
      deny_access unless signed_in?
    end

    def plan_params
    params.require(:plan).permit(:description1, :description2,:description3)
  end
end
