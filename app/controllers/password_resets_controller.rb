class PasswordResetsController < ApplicationController
  layout :custom_layout
  def create
    user = User.find_by_email(params[:email])

    if user
      
      user.send_password_reset
      redirect_to password_resets_new_url, :notice => "Email sent with password reset instructions."
    else
      redirect_to password_resets_new_url, :notice => "No account found with that email address."
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end
private
def custom_layout
        case action_name
         when "edit"
           "profile" 
         else
          "application"
        end
    end
end
