class UserVerification < ActionMailer::Base
  default from: "support@imeritize.com",
  bcc: "support@imeritize.com"

  def welcome_email(user,random_password)
    @user = user
    @random_password = random_password
   
    mail(:to => user.email, :subject => "Registration email")
  end

  
end
