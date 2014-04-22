class UserVerification < ActionMailer::Base
  default from: "atishkunalinfotech@gmail.com"

  def welcome_email(user,random_password)
    @user = user
    @random_password = random_password
   
    mail(:to => user.email, :subject => "Registration Email")
  end

  
end
