PayPal::SDK.load("config/paypal.yml", Rails.env)
PayPal::SDK.logger = Rails.logger

PayPal::Recurring.configure do |config|
	config.sandbox = true
	config.username = "meritize_api1.gmail.com"
	config.password = "1393481147"
	config.signature = "An5ns1Kso7MWUdW4ErQKJJJ4qi4-AtabrMytIC4-k8z2nrASkzE9BNfQ"
end 
