class UsersController < ApplicationController
   before_filter :authenticate, :only => [:edit, :update,:dashboard]
   before_filter :correct_user, :only => [:show]
   before_filter :correct_user_edit, :only => [:edit,:update]
   layout :custom_layout

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
   def toggled_status
        @users = User.find(params[:id])
        @users.status = !@users.status?
        @users.save!
        redirect_to "/admin_user"
    end


   def admin_user
        @searchuser ||= [] 
        @adminusers = User.find_all_by_admin_user_id(current_user.id, :conditions => ["firstname or lastname LIKE ?", "%#{params[:search]}%"])
        @adminusers.each do |adminuser|
        fullname = adminuser.fullname
        @searchuser << fullname
       end
       @searchuser
   end
   def adminuser_logs
       @searchuser ||= [] 
       @adminusers = AdminuserLog.find_all_by_admin_user_id(current_user.id, :conditions => ["firstname or lastname LIKE ?", "%#{params[:search]}%"])
       @adminusers.each do |adminuser|
        fullname = adminuser.fullname
        @searchuser << fullname
       end
       @searchuser 
   end


   def create
      @user = User.new(params[:user])
      @random_password = params[:user][:password]
      if @user.save
        @user.update_column(:fullname,"#{params[:user][:firstname]} #{params[:user][:lastname]} ")
        
            UserVerification.welcome_email(@user,@random_password).deliver
            
         if params[:page_name] == "admin"
           redirect_to admin_user_path ,:flash => {:notice => "User successfully created and temporay password send to user."}  
        
        else   
          redirect_to root_path, :flash => {:notice => "Hello #{@user.firstname} Please check your email for temporary password."}
        end  
      else
        @title = "Sign Up"
        render 'new'
      end
   end 
 
   def edit
    @title = "Edit user"
   end

   def update
    @user = User.find(params[:id])
         
    if @user.update_attributes(params[:user])
       @user.update_column(:fullname,"#{params[:user][:firstname]} #{params[:user][:lastname]} ")
      flash[:success] = "Profile updated."
      
      if params[:page_name] == "admin"
          redirect_to admin_user_path
      else
        flash[:success] = "Profile updated."
        redirect_to @user
      end  
    else
      @title = "Edit user"
      render 'edit'
    end
   end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "Successfully destroyed user."
      redirect_to  admin_user_path
    end

   def change_password

    @user = User.find(current_user.id)
    
    if request.post?
      if User.authenticate(@user.email,
        params[:change_password][:old_password]) == @user
        @user.password = params[:change_password][:new_password]
        @user.password_confirmation =
        params[:change_password][:new_password_confirmation]

          if @user.save
            flash[:notice] = 'Password successfully update'
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
    def authenticate
      deny_access unless signed_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to("/dashboard",:notice => 'You cannot access this page') unless current_user == @user
    end
    def correct_user_edit
       if current_user.role?(:admin)
        @user = User.find(params[:id])
        redirect_to("/dashboard",:notice => 'You cannot access this page') unless current_user.id == @user.admin_user_id || current_user.id == @user.id
       else
         @user = User.find(params[:id])
        redirect_to("/dashboard",:notice => 'You cannot access this page') unless current_user == @user
       end 
    end


    def assign_password
      (0..6).map{ ('a'..'z').to_a[rand(26)] }.join
    end
      def custom_layout
        case action_name
         when "edit"
          "admin" 
         when "dashboard"
          "admin" 
         when "show"
          "admin" 
         when "change_password"
          "admin"  
          when "admin_user"
          "admin" 
          when "adminuser_logs"
          "admin"
          when "add_adminuser"
          "admin"
         else
          "application"
        end
    end
   
 
end
