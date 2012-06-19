require 'spec_helper'
describe Spree::Admin::MailSettingsController ,:type=>"controller" do

	def mock_user(stubs={})
		@mock_user ||= mock_model(Spree::User, stubs).as_null_object
	end

	before(:each) do
		request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
		@current_user = Factory(:valid_user)
		controller.stub!(:current_user).and_return(@current_user)
		controller.stub!(:load_account).and_return("one")
		controller.stub!(:find_user_domain).and_return("cruxloc")
	end

	describe "GET update" do
    it "should be successful" do
			controller.stub!(:get_sub_domain).and_return("one")

			response.should be_success
		end
	end
end