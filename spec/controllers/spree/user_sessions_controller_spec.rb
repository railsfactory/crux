require 'spec_helper'
describe Spree::UserSessionsController, :type=>"controller" do
  include Devise::TestHelpers

  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = Factory(:valid_user)
    current_order = Factory(:valid_order)
    controller.stub!(:get_sub_domain).and_return("one")
    controller.stub!(:current_subdomain).and_return("one.cruxloc")
    controller.stub!(:current_user).and_return(@current_user)
    controller.stub!(:load_account).and_return("one")
  end

	describe "GET new" do
    it "should get view the new page" do
			get :new
			response.should be_success
    end
	end



	describe "GET destory" do
    it "should destroy a session for signed user" do
			delete :destroy
			response.should be_redirect
    end
	end


end