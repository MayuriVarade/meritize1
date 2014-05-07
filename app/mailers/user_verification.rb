class UserVerification < ActionMailer::Base
  default from: "Meritize <support@imeritize.com>",
  bcc: "amol@imeritize.com" # so that I get notified any time a customer signs up

  def welcome_email(user,random_password)
    @user = user
    @random_password = random_password
   
    mail(:to => user.email, :subject => "Registration email")
  end

  
end
