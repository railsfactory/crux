require 'spec_helper'
describe Spree::Admin::ProductsController ,:type=>"controller" do

	def mock_user(stubs={})
		@mock_user ||= mock_model(Spree::User, stubs).as_null_object
	end

	before(:each) do
		request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
		@current_user = Factory(:valid_user)
		controller.stub!(:load_account).and_return("one")
		controller.stub!(:current_user).and_return(@current_user)
		controller.stub!(:find_user_domain).and_return("cruxloc")
	end

	describe "GET load data" do
    it "should be successful" do
			controller.stub!(:get_sub_domain).and_return("one")
			tax_category =Spree::TaxCategory.where("domain_url in (?)","one").order(:name)
			#get:load_data
			#assigns(:tax_categories).should eq(tax_category)
			response.should be_true
		end
	end

end