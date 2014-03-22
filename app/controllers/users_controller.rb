class UsersController < ApplicationController
   before_filter :authenticate, :only => [:edit, :update,:dashboard]
   before_filter :correct_user, :only => [:show]
   before_filter :correct_user_edit, :only => [:edit,:update]
   before_filter :skip_password_attribute, only: :update
   layout :custom_layout
   require 'will_paginate/array'

    def show
      @user = User.find(params[:id])

    end

    def new
      #@random generates random value which wiil be used for generating temparay password.
      @random = (0..6).map{ ('a'..'z').to_a[rand(26)] }.join
      @user = User.new
      @title="Sign up"
    end

     def dashboard
        # @users = User.all
        @plans = Plan.all
        @trial_days = TrialDay.first
        @user = User.find_by_id(current_user)
        @plan_expiry = plan_expiry
       
     end
   # this method allows admin to activate or deactivate users
     def toggled_status
          @users = User.find(params[:id])
          @users.status = !@users.status?
          @users.update_column(:status,@users.status)
          
          redirect_to admin_user_path
      end

     def account_creation

     end

   #method for searching a admin_user and showing list of admin_user
     def admin_user
         @plan_expiry = plan_expiry
          @searchuser ||= []
          @adminusers = User.find_all_by_admin_user_id(current_user.id, :conditions => ["firstname || lastname || fullname LIKE ?", "%#{params[:search]}%"])
          @adminusers.each do |adminuser|
          fullname = adminuser.fullname
          @searchuser << fullname
         end
         @searchuser
     end

   #method for searching a adminuser_logs and showing list of adminuser_logs

     def adminuser_logs


         @searchuser ||= []

         @adminusers = AdminuserLog.find_all_by_admin_user_id(current_user.id, :conditions => ["firstname || lastname || fullname LIKE ?", "%#{params[:search]}%"]).paginate :page => params[:page],:per_page => 10

         @adminusers.each do |adminuser|
          fullname = adminuser.fullname
          @searchuser << fullname
         end
         @searchuser
     end

  #method for create new_user and sending them verification emails.
    def create
      @user = User.new(params[:user])
      @random_password = params[:user][:password]
    if @user.save
      @user.update_column(:fullname,"#{params[:user][:firstname]} #{params[:user][:lastname]} ")
            
      UserVerification.welcome_email(@user,@random_password).deliver
      if params[:page_name] == "admin"
      redirect_to admin_user_path ,:flash => {:notice => "User successfully created and temporary password sent to user."}
      else
      redirect_to account_creation_path, :flash => {:notice => "Hello #{@user.firstname}.Your brand new Meritize account is ready.
      We have sent login instructions to your email address.
      Contact us at support@imeritize.com if you have any questions."}
      end
      else
      @title = "Sign Up"
      render 'new'
      end
       end 
     
       def edit
        @title = "Edit user"
    end
   #method for create updating existing users.
     def update
        @user = User.find(params[:id])
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?

        @user.update_column(:fullname,"#{params[:user][:firstname]} #{params[:user][:lastname]} ")
        @user.update_column(:firstname,"#{params[:user][:firstname]}")
        @user.update_column(:lastname,"#{params[:user][:lastname]}")
        @user.update_column(:department,"#{params[:user][:department]}")
        if params[:page_name] == "admin" 
        flash[:success] = "Profile updated successfully."
        redirect_to admin_user_path
        elsif
        flash[:notice] = "Profile updated successfully."
        redirect_to @user
        else
       @title = "Edit user"
       render 'edit'
       end

    end
    #method for deleting users.
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "User deleted successfully."
      redirect_to admin_user_path
    end
    
   #method for change the users password to new password.
   def change_password

    @user = User.find(current_user.id)
    
    if request.post?
      if User.authenticate(@user.email,
        params[:change_password][:old_password]) == @user
        @user.password = params[:change_password][:new_password]
        @user.password_confirmation =
        params[:change_password][:new_password_confirmation]

          if @user.save
            flash[:notice] = 'Password successfully updated'
            redirect_to change_password_path
          else
            flash[:error] = 'New password mismatch'
            render :action => 'change_password'
          end
      else
          flash[:error] = 'Old password incorrect'
          render :action => 'change_password'
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
      @user = User.find(params[:id])
      redirect_to(user_root_path,:notice => 'You cannot access this page') unless current_user == @user
    end
    def correct_user_edit
       if current_user.role?(:admin)
        @user = User.find(params[:id])
        redirect_to(user_root_path,:notice => 'You cannot access this page') unless current_user.id == @user.admin_user_id || current_user.id == @user.id
       else
         @user = User.find(params[:id])
        redirect_to(user_root_path,:notice => 'You cannot access this page') unless current_user == @user
       end
    end
    

    def skip_password_attribute
    if params[:password].blank? && params[:password_validation].blank?
      params.except!(:password, :password_validation)
    end
  end


    def assign_password
      (0..6).map{ ('a'..'z').to_a[rand(26)] }.join
    end
    #method for allowing to user to use differnt layout to individual page.
      def custom_layout
        case action_name
         when "edit"
          "profile"
         when "dashboard"
          "profile"
         when "show"
          "profile"
         when "change_password"
          "profile"
          when "admin_user"
          "profile"
          when "adminuser_logs"
          "profile"
         when "add_adminuser"
          "profile"
         when "show"
          "profile"       
         else
          "application"
        end
    end
    
    
 
end
