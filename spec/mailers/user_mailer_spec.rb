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

		#should NOT be passing
		#it "should contain a link to the confirmation link" do
		#	should have_body_text("#{confirm_account_url}")
		#end
	end
end