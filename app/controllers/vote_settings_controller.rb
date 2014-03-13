class VoteSettingsController < ApplicationController
  # GET /vote_settings
  # GET /vote_settings.json
  layout 'profile'
  before_filter :authenticate, :only => [:edit, :update,:index,:show]
  before_filter :correct_user, :only => [:edit, :update,:show]

  def index
    @vote_settings = VoteSetting.find_all_by_user_id(current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @vote_settings }
    end
  end

  # GET /vote_settings/1
  # GET /vote_settings/1.json
  def show
    @vote_setting = VoteSetting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vote_setting }
    end
  end

  # GET /vote_settings/new
  # GET /vote_settings/new.json
  def new
    @vote_setting = VoteSetting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vote_setting }
    end
  end

  # GET /vote_settings/1/edit
  def edit
    @vote_setting = VoteSetting.find(params[:id])
    @past_vote_cycles = @vote_setting.vote_cycles
  end

  # POST /vote_settings
  # POST /vote_settings.json
  #method for creating vote_setting and new trigger cycles and pastcycles. 
  def create
    @vote_setting = VoteSetting.new(params[:vote_setting])
    sc =  @vote_setting.start_cycle.to_date
    ec =  @vote_setting.end_cycle.to_date
    #method for days validations when creating vote_setting and new trigger cycles and pastcycles. 
    if sc > ec 
      redirect_to :back ,:notice => "Start cycle cannot be greater."
    else
      diff = ec - sc + 1
        if diff < 28 || diff > 31
          redirect_to :back, :notice => "Please select proper date."
        else
          respond_to do |format|
            if @vote_setting.save
              format.html { redirect_to edit_vote_setting_path(@vote_setting), notice: 'Vote setting was successfully created.' }
              format.json { render json: @vote_setting, status: :created, location: @vote_setting }
            else
              format.html { render action: "new" }
              format.json { render json: @vote_setting.errors, status: :unprocessable_entity }
            end
          end
         end 
       end  
  end

  # PUT /vote_settings/1
  # PUT /vote_settings/1.json
  #method for updating vote_setting and new trigger cycles and pastcycles. 
  def update
    @vote_setting = VoteSetting.find(params[:id])
      vote_setting = params[:vote_setting]
    sc = %w(1 2 3).map { |e| vote_setting["start_cycle(#{e}i)"].to_i }
    ec = %w(1 2 3).map { |e| vote_setting["end_cycle(#{e}i)"].to_i }
    sc = sc.join("-").to_date
    ec = ec.join("-").to_date

    osc = @vote_setting.start_cycle
    oec = @vote_setting.end_cycle
    if sc > ec 
      redirect_to :back ,:notice => "Start cycle cannot be greater."
    else
       diff = ec - sc + 1
        if diff < 28 || diff > 31
          redirect_to :back, :notice => "Please select proper date."
        else 
            respond_to do |format|
              if @vote_setting.update_attributes(params[:vote_setting])
                @vote_cycle = VoteCycle.create(:start_cycle => osc ,:end_cycle => oec ,:user_id => current_user.id,:vote_setting_id => @vote_setting.id )
                format.html { redirect_to edit_vote_setting_path(@vote_setting), notice: 'Vote setting was successfully updated.' }
                format.json { head :no_content }
              else
                format.html { render action: "edit" }
                format.json { render json: @vote_setting.errors, status: :unprocessable_entity }
              end
            end
          end  
     end     
  end


  # DELETE /vote_settings/1
  # DELETE /vote_settings/1.json
  #method for deleting votesetting.
  def destroy
    @vote_setting = VoteSetting.find(params[:id])
    @vote_setting.destroy

    respond_to do |format|
      format.html { redirect_to vote_settings_url }
      format.json { head :no_content }
    end
  end
   #method for triggering new cycles. 
  def self.trigger_cycles

      @vote_cycle = VoteSetting.all
      @vote_cycle.each do |vc|
          if vc.award_frequency_type == "Monthly"
              if vc.end_cycle.to_date >= Date.today
                  VoteCycle.create(:start_cycle => vc.start_cycle,:end_cycle =>vc.end_cycle,:user_id =>vc.user_id,:vote_setting_id => vc.id)   
                  new_startcycle = vc.start_cycle.to_date + 1.month
                  new_endcycle   = vc.end_cycle.to_date + 1.month
                  @update_cycle = vc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
              end
          elsif vc.award_frequency_type == "Weekly"
               if vc.end_cycle.to_date >= Date.today
                  VoteCycle.create(:start_cycle => vc.start_cycle,:end_cycle =>vc.end_cycle,:user_id =>vc.user_id,:vote_setting_id => vc.id)   
                  new_startcycle = vc.start_cycle.to_date + 1.week
                  new_endcycle   = vc.end_cycle.to_date + 1.week
                  @update_cycle = vc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
              end 
          else
            if vc.end_cycle.to_date >= Date.today
                  VoteCycle.create(:start_cycle => vc.start_cycle,:end_cycle =>vc.end_cycle,:user_id =>vc.user_id,:vote_setting_id => vc.id)   
                  new_startcycle = vc.start_cycle.to_date + 3.month
                  new_endcycle   = vc.end_cycle.to_date + 3.month
                  @update_cycle  = vc.update_attributes(:start_cycle => new_startcycle,:end_cycle =>new_endcycle)
              end 
          end
      end
  end

   private
     #method for deny access if users try to access the pages without login.
    def authenticate
      deny_access unless signed_in?
    end
     #method for deny access if users try to access user details.
    def correct_user
      @vote_setting = VoteSetting.find(params[:id])
      unless @vote_setting.user_id == current_user.id
        redirect_to user_root_path, :notice => "Access Denied"
      end
    end
end
