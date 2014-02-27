class UsersController < ApplicationController
   before_filter :authenticate, :only => [:edit, :update]
   before_filter :correct_user, :only => [:edit, :update]
  
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
      @user = User.find_by_id(current_user)
      @plan_expiry = plan_expiry     
   end

   def create
      @user = User.new(params[:user])
      @random_password = params[:user][:password]
      if @user.save

        UserVerification.welcome_email(@user,@random_password).deliver
        redirect_to root_path, :flash => {:notice => "Hello #{@user.firstname} Please check your email for temporary password."}
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
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
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
    redirect_to(root_path) unless current_user=(@user)
  end
  def assign_password
  (0..6).map{ ('a'..'z').to_a[rand(26)] }.join
  end
  
end
