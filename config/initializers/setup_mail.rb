ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "atishkunalinfotech@gmail.com",
  :user_name            => "atishkunalinfotech",
  :password             => "!@#kunalinfotechkipl",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "drive-blogs.herokuapp.com/"
