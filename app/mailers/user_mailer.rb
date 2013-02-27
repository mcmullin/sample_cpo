class UserMailer < ActionMailer::Base
	default from: ENV['SMTP_USERNAME']

  def registration_confirmation(user)
  	@user = user
  	# attachments["rails.png"] = File.read("#{Rails.root}/app/assets/images/rails.png")
    mail(to: "#{user.name} <#{user.email}>", subject: "Welcome! Please confirm your account")
  end
end
