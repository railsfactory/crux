require 'spec_helper'
describe Spree::Admin::OptionTypesController ,:type=>"controller" do

	def mock_user(stubs={})
		@mock_user ||= mock_model(Spree::User, stubs).as_null_object
	end

	before(:each) do
		request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
		@current_user = Factory(:valid_user)
		#@product = Factory(:valid_product)

		controller.stub!(:current_user).and_return(@current_user)
		controller.stub!(:product).and_return(@product)
		controller.stub!(:load_account).and_return("one")
		controller.stub!(:find_user_domain).and_return("one")
		controller.stub!(:find_user_domain).and_return("cruxloc")
	end


end