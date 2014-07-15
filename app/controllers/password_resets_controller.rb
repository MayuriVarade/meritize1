class PasswordResetsController < ApplicationController
  layout 'application'

  #method for sending the temporary passowrd for passowrd reset.
  def create
    user = User.find_by_email(params[:email])

    if user
      
      user.send_password_reset
      redirect_to password_resets_new_url, :notice => "A new password has been set and emailed to you. Follow the instructions in the email to start using the new password."
    else
      redirect_to password_resets_new_url, :notice => "Sorry, we could not locate a Meritize user with that email address"
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "The new password we set for you has expired. You need to request another password."
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Password has been reset! Log in with your new password to continue."
    else
      render :edit
    end
  end
  #method for allowing to user to use differnt layout to individual page.
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
