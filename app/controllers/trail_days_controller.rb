class TrailDaysController < ApplicationController
  # GET /trail_days
  # GET /trail_days.json
  def index
    @trail_days = TrailDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trail_days }
    end
  end

  # GET /trail_days/1
  # GET /trail_days/1.json
  def show
    @trail_day = TrailDay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trail_day }
    end
  end

  # GET /trail_days/new
  # GET /trail_days/new.json
  def new
    @trail_day = TrailDay.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trail_day }
    end
  end

  # GET /trail_days/1/edit
  def edit
    @trail_day = TrailDay.find(params[:id])
  end

  # POST /trail_days
  # POST /trail_days.json
  def create
    @trail_day = TrailDay.new(params[:trail_day])

    respond_to do |format|
      if @trail_day.save
        format.html { redirect_to @trail_day, notice: 'Trail day was successfully created.' }
        format.json { render json: @trail_day, status: :created, location: @trail_day }
      else
        format.html { render action: "new" }
        format.json { render json: @trail_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trail_days/1
  # PUT /trail_days/1.json
  def update
    @trail_day = TrailDay.find(params[:id])

    respond_to do |format|
      if @trail_day.update_attributes(params[:trail_day])
        format.html { redirect_to @trail_day, notice: 'Trail day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trail_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trail_days/1
  # DELETE /trail_days/1.json
  def destroy
    @trail_day = TrailDay.find(params[:id])
    @trail_day.destroy

    respond_to do |format|
      format.html { redirect_to trail_days_url }
      format.json { head :no_content }
    end
  end
end
