class PropsController < ApplicationController
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
  end

  # POST /props
  # POST /props.json
  def create
    @prop = Prop.new(params[:prop])
    sc =  @prop.start_cycle.to_date
    ec =  @prop.end_cycle.to_date
    if sc > ec 
      redirect_to :back ,:notice => "Start cycle cannot be greater."
    else
      diff = ec - sc + 1
        if diff < 28 || diff > 31
          redirect_to :back, :notice => "Please select proper date."
        else
          respond_to do |format|
            if @prop.save
              format.html { redirect_to :back, notice: 'Prop was successfully created.' }
              format.json { render json: @prop, status: :created, location: @prop }
            else
              format.html { render action: "new" }
              format.json { render json: @prop.errors, status: :unprocessable_entity }
            end
          end
        end
    end
  end

  # PUT /props/1
  # PUT /props/1.json
  def update
    @prop = Prop.find(params[:id])
    prop = params[:prop]
    sc = %w(1 2 3).map { |e| prop["start_cycle(#{e}i)"].to_i }
    ec = %w(1 2 3).map { |e| prop["end_cycle(#{e}i)"].to_i }
    sc = sc.join("-").to_date
    ec = ec.join("-").to_date

    osc = @prop.start_cycle
    oec = @prop.end_cycle
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
              format.html { redirect_to :back, notice: 'Prop was successfully updated.' }
              format.json { head :no_content }
            else
              format.html { render action: "edit" }
              format.json { render json: @prop.errors, status: :unprocessable_entity }
            end
          end
        end
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
end
