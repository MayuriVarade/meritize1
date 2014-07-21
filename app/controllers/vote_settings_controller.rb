class VoteSettingsController < ApplicationController
  # GET /vote_settings
  # GET /vote_settings.json
  layout 'profile'
  before_filter :authenticate, :only => [:edit, :update,:index,:show,:new]
  before_filter :correct_user, :only => [:edit, :update,:show]

  def index
    
    @vote_settings = VoteSetting.find_all_by_user_id(current_user.id).last

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
    @past_vote_cycles = @vote_setting.vote_cycles.order("created_at DESC")
  end

  # POST /vote_settings
  # POST /vote_settings.json
  #method for creating vote_setting and new trigger cycles and pastcycles. 
  def create
    @users =  User.where("admin_user_id = ? ",current_user.id)
    @vote_setting = VoteSetting.new(params[:vote_setting])
    sc =   params[:vote_setting][:start_cycle].to_s.to_date
    ec =   params[:vote_setting][:end_cycle].to_s.to_date
    reminder1_days = params[:vote_setting][:reminder1_days].to_i
    reminder2_days = params[:vote_setting][:reminder2_days].to_i 
    reminder3_days = params[:vote_setting][:reminder3_days].to_i

  if (reminder1_days < 0) || (reminder2_days < 0) || (reminder3_days < 0)
    redirect_to :back ,:notice => "Settings not saved. Reminder days entry can not be less than 0 days."
  else

    #method for days validations when creating vote_setting and new trigger cycles and pastcycles. 
  if params[:vote_setting][:award_frequency_type] == "Monthly"
    if sc.present? && ec.present?

    if sc > ec 
      redirect_to :back ,:notice => "Settings not saved. The cycle start date is after the cycle end date." 
    else
      diff = (ec - sc + 1).round
        if diff < 28 || diff > 31
          redirect_to :back, :notice => "Settings not saved. You have selected a monthly cycle but the cycle timeframe does not seem to be a month long."
        elsif (reminder1_days > 31) || (reminder2_days > 31) || (reminder3_days > 31)
          redirect_to :back, :notice => "Settings not saved. You have selected a monthly cycle but the reminder days entry is more than 31 days."      
        else
          respond_to do |format|
            if @vote_setting.save
                              
              format.html { redirect_to edit_vote_setting_path(@vote_setting), notice: 'Settings for vote were successfully created.' }
              format.json { render json: @vote_setting, status: :created, location: @vote_setting }
            else
              format.html { render action: "new" }
              format.json { render json: @vote_setting.errors, status: :unprocessable_entity }
            end
          end
         end 
       end 
      else
      redirect_to :back, :notice=> "Settings not saved. Looks like you missed filling out some settings."
    end 
  elsif params[:vote_setting][:award_frequency_type] == "Weekly"

    if sc.present? && ec.present?

    if sc > ec 
      redirect_to :back ,:notice => "Settings not saved. The cycle start date is after the cycle end date." 
    else
      diff = (ec - sc + 1).round
        if diff < 5 || diff > 8
          redirect_to :back, :notice => "Settings not saved. You have selected a weekly cycle but the cycle timeframe does not seem to be a week long."
        elsif (reminder1_days > 7) || (reminder2_days > 7) || (reminder3_days > 7)
          redirect_to :back, :notice => "Settings not saved. You have selected a weekly cycle but the reminder days entry is more than 7 days."  
        else
          respond_to do |format|
            if @vote_setting.save
                              
              format.html { redirect_to edit_vote_setting_path(@vote_setting), notice: 'Settings for vote were successfully created.' }
              format.json { render json: @vote_setting, status: :created, location: @vote_setting }
            else
              format.html { render action: "new" }
              format.json { render json: @vote_setting.errors, status: :unprocessable_entity }
            end
          end
         end 
       end 
      else
      redirect_to :back, :notice=> "Settings not saved. Looks like you missed filling out some settings."
    end 
   elsif params[:vote_setting][:award_frequency_type] == "Quaterly"  
      if sc > ec 
        redirect_to :back ,:notice => "Settings not saved. The cycle start date is after the cycle end date." 
      
        diff = (ec - sc + 1).round
          if diff < 89 || diff > 92
            redirect_to :back, :notice => "Settings not saved. You have selected a quarterly cycle but the cycle timeframe does not seem to be a quarter long."
          elsif (reminder1_days > 90) || (reminder2_days > 90) || (reminder3_days > 90)
          redirect_to :back, :notice => "Settings not saved. You have selected a quarterly cycle but the reminder days entry is more than 90 days."    
          else
            respond_to do |format|
              if @vote_setting.save
                                
                format.html { redirect_to edit_vote_setting_path(@vote_setting), notice: 'Settings for vote were successfully created.' }
                format.json { render json: @vote_setting, status: :created, location: @vote_setting }
              else
                format.html { render action: "new" }
                format.json { render json: @vote_setting.errors, status: :unprocessable_entity }
              end
            end
           end 
      else
      redirect_to :back, :notice=> "Settings not saved. Looks like you missed filling out some settings."    
      end 
     
    end
  end
end

  # PUT /vote_settings/1
  # PUT /vote_settings/1.json
  #method for updating vote_setting and new trigger cycles and pastcycles. 
  def update
    @vote_setting = VoteSetting.find(params[:id])
    sc =  params[:vote_setting][:start_cycle].to_s.to_date
    ec =  params[:vote_setting][:end_cycle].to_s.to_date

    osc = @vote_setting.start_cycle
    oec = @vote_setting.end_cycle

    reminder1_days = params[:vote_setting][:reminder1_days].to_i
    reminder2_days = params[:vote_setting][:reminder2_days].to_i 
    reminder3_days = params[:vote_setting][:reminder3_days].to_i

  if (reminder1_days < 0) || (reminder2_days < 0) || (reminder3_days < 0)
   redirect_to :back ,:notice => "Settings not saved. Reminder days entry can not be less than 0 days."
  else


    if params[:vote_setting][:award_frequency_type] == "Monthly"  
        if sc > ec 
          redirect_to :back ,:notice => "Settings not saved. The cycle start date is after the cycle end date."

        else
           diff = ec - sc + 1
            if diff < 28 || diff > 31
              redirect_to :back, :notice => "Settings not saved. You have selected a monthly cycle but the cycle timeframe does not seem to be a month long."
            elsif (reminder1_days > 31) || (reminder2_days > 31) || (reminder3_days > 31)
                    redirect_to :back, :notice => "Settings not saved. You have selected a monthly cycle but the reminder days entry is more than 31 days."    
            else 
                respond_to do |format|
                  if @vote_setting.update_attributes(params[:vote_setting])
                    if sc != osc || ec != oec
                      @vote_cycle = VoteCycle.create(:start_cycle => osc ,:end_cycle => oec ,:user_id => current_user.id,:vote_setting_id => @vote_setting.id,:award_program_name =>@vote_setting.award_program_name)
                    end
                    format.html { redirect_to edit_vote_setting_path(@vote_setting), notice: 'Vote settings were successfully updated.' }
                    format.json { head :no_content }
                  else
                    format.html { render action: "edit" }
                    format.json { render json: @vote_setting.errors, status: :unprocessable_entity }
                  end
                end
              end  
         end 
    elsif params[:vote_setting][:award_frequency_type] == "Weekly"
         if sc > ec 
          redirect_to :back ,:notice => "Settings not saved. The cycle start date is after the cycle end date."
         elsif (reminder1_days > 7) || (reminder2_days > 7) || (reminder3_days > 7)
          redirect_to :back, :notice => "Settings not saved. You have selected a weekly cycle but the reminder days entry is more than 7 days."   
        else
           diff = ec - sc + 1
            if diff < 5 || diff > 8
              redirect_to :back, :notice => "Settings not saved. You have selected a weekly cycle but the cycle timeframe does not seem to be a week long."
            else 
                respond_to do |format|
                  if @vote_setting.update_attributes(params[:vote_setting])
                    if sc != osc || ec != oec
                      @vote_cycle = VoteCycle.create(:start_cycle => osc ,:end_cycle => oec ,:user_id => current_user.id,:vote_setting_id => @vote_setting.id,:award_program_name =>@vote_setting.award_program_name)
                    end
                    format.html { redirect_to edit_vote_setting_path(@vote_setting), notice: 'Vote settings were successfully updated.' }
                    format.json { head :no_content }
                  else
                    format.html { render action: "edit" }
                    format.json { render json: @vote_setting.errors, status: :unprocessable_entity }
                  end
                end
              end  
         end
    elsif params[:vote_setting][:award_frequency_type] == "Quaterly"
        if sc > ec 
        redirect_to :back ,:notice => "Settings not saved. The cycle start date is after the cycle end date."
        elsif (reminder1_days > 90) || (reminder2_days > 90) || (reminder3_days > 90)
          redirect_to :back, :notice => "Settings not saved. You have selected a quarterly cycle but the reminder days entry is more than 90 days."    
        else
         diff = ec - sc + 1
          if diff < 89 || diff > 92
            redirect_to :back, :notice => "Settings not saved. You have selected a quarterly cycle but the cycle timeframe does not seem to be a quarter long."
          else 
              respond_to do |format|
                if @vote_setting.update_attributes(params[:vote_setting])
                  if sc != osc || ec != oec
                    @vote_cycle = VoteCycle.create(:start_cycle => osc ,:end_cycle => oec ,:user_id => current_user.id,:vote_setting_id => @vote_setting.id,:award_program_name =>@vote_setting.award_program_name)
                  end
                  format.html { redirect_to edit_vote_setting_path(@vote_setting), notice: 'Vote settings were successfully updated.' }
                  format.json { head :no_content }
                else
                  format.html { render action: "edit" }
                  format.json { render json: @vote_setting.errors, status: :unprocessable_entity }
                end
              end
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
