class VoteSettingsController < ApplicationController
  # GET /vote_settings
  # GET /vote_settings.json
  def index
    @vote_settings = VoteSetting.all

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
    @past_vote_cycles = VoteCycle.find_all_by_vote_setting_id(@vote_setting.id)
  end

  # POST /vote_settings
  # POST /vote_settings.json
  def create
    @vote_setting = VoteSetting.new(params[:vote_setting])
    
    respond_to do |format|
      if @vote_setting.save
        format.html { redirect_to @vote_setting, notice: 'Vote setting was successfully created.' }
        format.json { render json: @vote_setting, status: :created, location: @vote_setting }
      else
        format.html { render action: "new" }
        format.json { render json: @vote_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /vote_settings/1
  # PUT /vote_settings/1.json
  def update
    @vote_setting = VoteSetting.find(params[:id])
     
    respond_to do |format|
      if @vote_setting.update_attributes(params[:vote_setting])
        @vote_cycle = VoteCycle.create(:start_cycle => @vote_setting.start_cycle ,:end_cycle => @vote_setting.end_cycle ,:user_id => current_user.id,:vote_setting_id => @vote_setting.id )
        format.html { redirect_to @vote_setting, notice: 'Vote setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vote_setting.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /vote_settings/1
  # DELETE /vote_settings/1.json
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
end
