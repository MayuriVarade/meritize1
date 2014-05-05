ActionMailer::Base.smtp_settings = {
  :user_name => 'meritize',
  :password => 'Meritgrid14!',
  :domain => 'imeritize.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "https://meritize.herokuapp.com/"