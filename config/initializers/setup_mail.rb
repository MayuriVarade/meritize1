ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "localhost",
  :authentication => :login,
  :user_name => "rubyrails9@gmail.com",
  :password => "kipl123!@#"

}

ActionMailer::Base.default_url_options[:host] = "meritize-test.herokuapp.com/"