require 'spec_helper'
describe Spree::Admin::OrdersController ,:type=>"controller" do
  def mock_user(stubs={})
		@mock_user ||= mock_model(Spree::User, stubs).as_null_object
	end

	before(:each) do
		request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
		@current_user = Factory(:valid_user)
		@order = Factory(:valid_order)
		@product = Factory(:valid_product)
		@country = Factory(:valid_country)
		@state = Factory(:valid_state)
		@store = Factory(:valid_store_ower)
    controller.stub!(:load_account).and_return("one")
		controller.stub!(:current_user).and_return(@current_user)
		controller.stub!(:find_user_domain).and_return("cruxloc")
	end
	describe "GET index" do
    it "should be successful" do
			controller.stub!(:get_sub_domain).and_return("one")
			get :index,{:q=>{"completed_at_gt"=>"", "completed_at_lt"=>"", "completed_at_not_null"=>"1", "meta_sort"=>"completed_at.desc", "s"=>"completed_at asc"}}
			response.should be_success
		end
	end

end