require 'spec_helper'

describe UserMailer do
	let(:user) { FactoryGirl.create(:user) }

	describe "registration confirmation email" do
		before { @email = UserMailer.registration_confirmation(user) }

		subject { @email }

		it "should deliver to the correct address" do
			should deliver_to("#{user.name} <#{user.email}>")
		end

		it "should have the correct subject" do
			should have_subject("Welcome! Please confirm your account")
		end

		it "should contain welcome body text" do
			should have_body_text("Thank you for registering!")
		end

		it "should contain a link to confirm the user" do
			should have_body_text(url_for(only_path: false,
																		controller: "users", 
																		id: "#{user.id}", 
																		action: "confirm", 
																		confirmation_code: "#{user.confirmation_code}"))
		end
	end
end