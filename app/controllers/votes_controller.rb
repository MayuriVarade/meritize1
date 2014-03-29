class VotesController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update,:index,:show,:new]
  layout 'profile'

    def index
    end
    # method for submitting votes.
    def new
        @votes = Vote.find_by_voter_id(current_user)

        @vote_setting_enddate = current_user.admin_user.vote_setting.end_cycle.to_date rescue nil  
        @votes_last = Vote.find_all_by_voter_id(current_user.id,:order => "id desc").first
        
        @vote_setting = current_user.admin_user.vote_setting 
        
        @vote = Vote.new
        
        @setting = current_user.admin_user.setting
        unless current_user.admin_user.setting.nil? 
          @core_values = @setting.core_values 
        end
         @nominees = Nominee.where("start_cycle ='#{@vote_setting.start_cycle}' AND end_cycle ='#{@vote_setting.end_cycle }' AND current_user_id = '#{current_user.admin_user_id}'") rescue nil
        
          if @nominees.present?
                 @searchuser ||= [] 
                  @nomineeusers = Nominee.where(["firstname || lastname || fullname LIKE ? and user_id != ? and current_user_id = ? and current_user_id is not null and start_cycle = ? and end_cycle = ?
                    ", "%#{params[:search]}%",current_user.id,current_user.admin_user_id,"#{@vote_setting.start_cycle.to_date}","#{@vote_setting.end_cycle.to_date}"])
                  @nomineeusers.each do |nomineeuser|
                  fullname = nomineeuser.fullname + "(" + nomineeuser.email + ")"
                  @searchuser << fullname
                 end
                 @searchuser
               
          else
              @searchuser ||= [] 
              @adminusers = User.where(["firstname || lastname || fullname LIKE ? and id != ? and admin_user_id = ? and admin_user_id is not null", "%#{params[:search]}%",current_user.id,current_user.admin_user_id])

              @adminusers.each do |adminuser|
                fullname = adminuser.fullname + "(" + adminuser.email + ")"
                @searchuser << fullname
              end
              @searchuser
               
          end
       
    end
    # method for submitting votes and overidding previous votes. 
    def create
       @votes = Vote.find_by_voter_id(current_user)
       @vote_setting = current_user.admin_user.vote_setting.end_cycle.to_date
       @votes_last = Vote.find_all_by_voter_id(current_user).last 
       @vote_setting1 = current_user.admin_user.vote_setting 
       voteable_params = params[:vote][:voteable_id]
       voteable_split = voteable_params.split(" ") rescue nil
       voteable_fullname = voteable_split[0] + " " + voteable_split[1] rescue nil
       voteable_email1 = voteable_split[2]
       voteable_email = voteable_email1.gsub(/[()]/, "") rescue nil
       
       voteable = User.where(["fullname LIKE ? and email LIKE ?", "%#{voteable_fullname}%","%#{voteable_email}%"])
       voteable_id = voteable[0].id
        @nominees = Nominee.where("start_cycle ='#{@vote_setting1.start_cycle}' AND end_cycle ='#{@vote_setting1.end_cycle }' AND current_user_id = '#{current_user.admin_user_id}'")
        if @nominees.present?
           nomineeemail = Nominee.where('email = ?',voteable_email)
        else
          nomineeemail =  User.where(["id != ? and admin_user_id = ? and admin_user_id is not null and email = ?",current_user.id,current_user.admin_user_id,voteable_email])
        end  
       
    if (voteable_params.present?) && (params[:vote][:description].present?) && (params[:vote][:core_values].present?)  
        if nomineeemail.present?
          unless @votes.present? && @votes.vote_setting_id.present? && @vote_setting == @votes_last.cycle_end_date.to_date
            @vote = Vote.new(params[:vote])
            @vote.voteable_id = voteable_id
            
            if @vote.save
              flash[:success] = "Vote for this user successfully submitted."
              redirect_to :back
            end 
          else
            Vote.update(@votes_last.id, :voter_id => current_user.id, :core_values => params[:vote][:core_values], :voteable_id =>voteable_id,:description =>params[:vote][:description],:vote_setting_id =>params[:vote][:vote_setting_id],:cycle_end_date => params[:vote][:cycle_end_date],:cycle_start_date => params[:vote][:cycle_start_date])
            flash[:success] = "Vote for this user successfully changed."
            redirect_to :back
          end

        else
          flash[:notice] = "Sorry, we cannot find that person. It's also possible that he/she has not been nominated."
          redirect_to :back 
        end
    else

     redirect_to :back, :notice=> "Sorry, we cannot find that person. It's also possible that he/she has not been nominated."    
   end

  end

    # scheduler method for triggering reminder_email1. 
    def self.reminder_email1
      admin_user = User.where("username is null  and admin_user_id is null")
      admin_user.each do |au|
        users = User.where("admin_user_id = ?",au.id)
        users.each do |user|
          @vote_setting = user.admin_user.vote_setting
         unless @vote_setting.nil? 
          @vote_reminder1_days = ( @vote_setting.start_cycle.to_date + @vote_setting.reminder1_days )
            if Vote.where("created_at >= '#{@vote_setting.start_cycle.to_date}' AND created_at <='#{@vote_reminder1_days}' AND voter_id = '#{user.id}'").empty?
                      
              vote_setting = au.vote_setting
              if (user.is_vote_reminder) == true
                puts user.inspect
                VoteMailer.vote_mail(user,vote_setting).deliver
              end  
            end
           end 
          end  
        end
    end
    # scheduler method for triggering reminder_email2. 
    def self.reminder_email2
      admin_user = User.where("username is null  and admin_user_id is null")
      admin_user.each do |au|
        users = User.where("admin_user_id = ?",au.id)
        users.each do |user|
          @vote_setting = user.admin_user.vote_setting
        unless @vote_setting.nil?  
          @vote_reminder2_days = ( @vote_setting.start_cycle.to_date + @vote_setting.reminder2_days )
          if Vote.where("created_at >= '#{@vote_setting.start_cycle.to_date}' AND created_at <='#{@vote_reminder2_days}' AND voter_id = '#{user.id}'").empty?
                        
            vote_setting = au.vote_setting
             if (user.is_vote_reminder) == true 
              puts user.inspect  
              VoteMailer.vote_mail_reminder2(user,vote_setting).deliver
             end 
          end
         end 
        end
       end 
    end  
    # scheduler method for triggering reminder_email3. 
    def self.reminder_email3
      admin_user = User.where("username is null  and admin_user_id is null")
      admin_user.each do |au|
        users = User.where("admin_user_id = ?",au.id)
        users.each do |user|
          @vote_setting = user.admin_user.vote_setting
        unless @vote_setting.nil?  
          @vote_reminder2_days = ( @vote_setting.start_cycle.to_date + @vote_setting.reminder2_days )
          if Vote.where("created_at >= '#{@vote_setting.start_cycle.to_date}' AND created_at <='#{@vote_reminder2_days}' AND voter_id = '#{user.id}'").empty?
                       
            vote_setting = au.vote_setting
            if (user.is_vote_reminder) == true 
              puts user.inspect  
              VoteMailer.vote_mail_reminder3(user,vote_setting).deliver
            end  
          end
         end 
        end
      end

    end  



    private
     #method for deny access if users try to access the pages without login.
    def authenticate
      deny_access unless signed_in?
    end

end
