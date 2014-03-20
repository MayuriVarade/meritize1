class PropsController < ApplicationController
  before_filter :authenticate
  before_filter :correct_user, :only => [:edit, :update,:show]

  layout 'profile'
  # GET /props
  # GET /props.json
  def index
    @props = Prop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @props }
    end
  end

  # GET /props/1
  # GET /props/1.json
  def show
    @prop = Prop.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @prop }
    end
  end

  # GET /props/new
  # GET /props/new.json
  def new
    @prop = Prop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @prop }
    end
  end

  # GET /props/1/edit
  def edit
    @prop = Prop.find(params[:id])
    @past_cycles = @prop.prop_cycles

  end

  # POST /props
  # POST /props.json
  def create

    @prop = Prop.new(params[:prop])
     sc =   params[:prop][:start_cycle].to_s.to_date
     ec =   params[:prop][:end_cycle].to_s.to_date
     sp = params[:prop][:start_point].to_s
     ep = params[:prop][:end_point].to_s
    
    if sc.present? && ec.present?
    if sc > ec 
      redirect_to :back ,:notice => "Start cycle cannot be greater."
    elsif
       diff = (ec - sc + 1).round
        if diff < 28 || diff > 31
          redirect_to :back, :notice => "Please select proper date."
        elsif sp > ep
        redirect_to :back ,:notice => "Start Point cannot be grater than End Point"
      else
          respond_to do |format|
            if @prop.save
              format.html { redirect_to edit_prop_path(@prop), notice: 'Settings for props were successfully created.' }
              format.json { render json: @prop, status: :created, location: @prop }
            else
              format.html { render action: "new" }
              format.json { render json: @prop.errors, status: :unprocessable_entity }
            end
          end
        end
      end
    else
      redirect_to :back, :notice=> "Please fill the all record"
    end 
  end

  # PUT /props/1
  # PUT /props/1.json
  def update
    @prop = Prop.find(params[:id])
   
    sc =  params[:prop][:start_cycle].to_s.to_date
    ec =  params[:prop][:end_cycle].to_s.to_date
    osc = params[:prop][:start_cycle].to_s.to_date
    oec = params[:prop][:end_cycle].to_s.to_date
    
    if sc.present? && ec.present?
    if sc > ec 
      redirect_to :back ,:notice => "Start cycle cannot be greater."
    else
       diff = ec - sc + 1
        if diff < 28 || diff > 31
          redirect_to :back, :notice => "Please select proper date."
        else
          respond_to do |format|
            if @prop.update_attributes(params[:prop])
              PropCycle.create(:start_cycle => osc, :end_cycle => oec, :user_id => current_user.id, :prop_id => @prop.id)
              format.html { redirect_to :back, notice: 'Settings for props were successfully created.' }
              format.json { head :no_content }
            else
              format.html { render action: "edit" }
              format.json { render json: @prop.errors, status: :unprocessable_entity }
            end
          end
        end
      end
      else
      redirect_to :back, :notice=> "Please fill the all record"
    end
  end

  # DELETE /props/1
  # DELETE /props/1.json
  def destroy
    @prop = Prop.find(params[:id])
    @prop.destroy

    respond_to do |format|
      format.html { redirect_to props_url }
      format.json { head :no_content }
    end
  end

  private
    
    def authenticate
      deny_access unless signed_in?
    end

    def correct_user
      @prop = Prop.find(params[:id])
      unless @prop.user_id == current_user.id
        redirect_to user_root_path, :notice => "Access Denied"
      end
    end
    

end
