class TrialDaysController < ApplicationController

   before_filter :authenticate, :only => [:edit, :update,:show,:new,:index]

  layout "admin"
  # GET /trial_days
  # GET /trial_days.json
  def index
    @trial_days = TrialDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trial_days }
    end
  end

  # GET /trial_days/1
  # GET /trial_days/1.json
  def show
    @trial_day = TrialDay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trial_day }
    end
  end

  # GET /trial_days/new
  # GET /trial_days/new.json
  def new
    @trial_day = TrialDay.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trial_day }
    end
  end

  # GET /trial_days/1/edit
  def edit
    @trial_day = TrialDay.find(params[:id])
  end

  # POST /trial_days
  # POST /trial_days.json
  def create
    @trial_day = TrialDay.new(params[:trial_day])

    respond_to do |format|
      if @trial_day.save
        format.html { redirect_to @trial_day, notice: 'Trial day was successfully created.' }
        format.json { render json: @trial_day, status: :created, location: @trial_day }
      else
        format.html { render action: "new" }
        format.json { render json: @trial_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trial_days/1
  # PUT /trial_days/1.json
  def update
    @trial_day = TrialDay.find(params[:id])

    respond_to do |format|
      if @trial_day.update_attributes(params[:trial_day])
        format.html { redirect_to @trial_day, notice: 'Trial day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trial_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trial_days/1
  # DELETE /trial_days/1.json
  def destroy
    @trial_day = TrialDay.find(params[:id])
    @trial_day.destroy

    respond_to do |format|
      format.html { redirect_to trial_days_url }
      format.json { head :no_content }
    end
  end

private
    def authenticate
      deny_access unless signed_in?
    end
  
end
