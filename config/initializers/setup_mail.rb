require 'development_mail_interceptor'

ActionMailer::Base.raise_delivery_errors = true

ActionMailer::Base.smtp_settings = {
	address:              "smtp.gmail.com",
	port:                 587,
	domain:               ENV['SMTP_DOMAIN'],
	user_name:            ENV['SMTP_USERNAME'],
	password:             ENV['SMTP_PASSWORD'],
	authentication:       "plain",
	enable_starttls_auto: true
}

ActionMailer::Base.default_url_options[:host] = "localhost:5000" if !Rails.env.production?
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
