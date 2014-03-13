PayPal::SDK.load("config/paypal.yml", Rails.env)
PayPal::SDK.logger = Rails.logger

PayPal::Recurring.configure do |config|
	config.sandbox = true
	config.username = "kipl456_api1.gmail.com"
	config.password = "1394623811"
	config.signature = "AFcWxV21C7fd0v3bYYYRCpSSRl31Ar1DAqAJG0GsdwyQmldV.XxRssk."
end 



