ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "mayuri.kiplh@gmail.com",
  :user_name            => "mayuri.kipl",
  :password             => "kipl12345",

  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "http://meritize-test.herokuapp.com/"