class UserMailer < ActionMailer::Base
 default from: "Meritize <support@imeritize.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password reset"
  end

  def welcome_email(user)
        @user = user
        
        @url  = 'http://sandbox.paypal.com'
        mail(
          to: user.email,
          subject: 'Welcome to Paypal'
        )
  end

  def decline_email(user)
    @user = user
    mail :to => user.email, :subject => "Decline Payment"
  end 

  def trialday_reminder_mail(user,user_expiry)
        @user_expiry = user_expiry
        @user = user
        mail :to => user.email, :subject => "Paypal Subscription Trial Days"
  end

  def user_status_mail(user)
    @user = user
    # @url = 'http://sandbox.paypal.com'
    mail(
          to: user.email,
          subject: 'Meritize login status'
        )
  end

  def uploaduser_verifymail(user,random_password)
   @user = user
   @random_password = random_password
    mail(
      to: user.email,
      subject: 'Verification mail'
      )
  end  


end
