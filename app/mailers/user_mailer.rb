class UserMailer < ActionMailer::Base
	default from: ENV['SMTP_USERNAME']

  def registration_confirmation(user)
  	@user = user
    mail to: "#{user.name} <#{user.email}>", subject: "Welcome! Please confirm your account"
  end
end
