require 'spec_helper'
describe Spree::Admin::InventorySettingsController ,:type=>"controller" do

	def mock_user(stubs={})
		@mock_user ||= mock_model(Spree::User, stubs).as_null_object
	end

	before(:each) do
		request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
		@current_user = Factory(:valid_user)
		controller.stub!(:current_user).and_return(@current_user)
		controller.stub!(:find_user_domain).and_return("cruxloc")
		controller.stub!(:load_account).and_return("one")
	end

  describe "PUT update" do
    it "should be successful" do
			controller.stub!(:get_sub_domain).and_return("siva")
			put:update, {:preferences=>{"domain_url"=>"one", "show_zero_stock_products"=>"1", "allow_backorders"=>"1"}}
			response.should be_true
		end
	end

end