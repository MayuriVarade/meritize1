ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "rubyrails9@gmail.com",
  :user_name            => "rubyrails9",
  :password             => "kipl123!@#",

  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "http://meritize-test.herokuapp.com/"