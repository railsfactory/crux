require 'spec_helper'
describe Spree::Admin::MailMethodsController ,:type=>"controller" do

	def mock_user(stubs={})
		@mock_user ||= mock_model(Spree::User, stubs).as_null_object
	end

	before(:each) do
		request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
		@current_user = Factory(:valid_user)
		controller.stub!(:load_account).and_return("one")
		controller.stub!(:current_user).and_return(@current_user)
		controller.stub!(:find_user_domain).and_return("cruxloc")
		controller.stub!(:respond_with).and_return(true)
	end

	describe "GET update" do
    it "should be successful" do
			controller.stub!(:get_sub_domain).and_return("one")
			mail=Spree::MailMethod.create(:environment=> "development",:domain_url=>"one")
			response.should be_true
      #flash.now[:error].should eql("You are not a registered user of this site")
		end
	end

end