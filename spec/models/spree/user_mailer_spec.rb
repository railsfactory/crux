require 'spec_helper'
describe Spree::UserMailer do
	
include Spree::BaseHelper
		 before(:each) do
ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = false
ActionMailer::Base.deliveries = []

@user = Spree::User.create( :password=>"123456", :password_confirmation=>"123456", :email=>"rajutaya@rediffmail.com")
#Spree::UserSession.create(@user)
end

 it 'password_reset_instructions' do
@mailer = stub(:deliver)
#Spree::UserMailer.expects(:password_reset_instructions).once.returns(@mailer)
end


	
  end