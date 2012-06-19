require 'spec_helper'
describe Spree::PasswordController ,:type=>"controller" do
  include Devise::TestHelpers

  def mock_user(stubs={})
    @mock_user ||= mock_model(Spree::User, stubs).as_null_object
  end

  before(:each) do
    request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
    @current_user = Factory(:valid_user)
    controller.stub!(:get_sub_domain).and_return("one")
    controller.stub!(:load_account).and_return("one")
  end

	describe "GET reset_password" do
    it "find the user using the password token" do
			get :reset_password,:token=> "COm3ZYP5hj1Q3stdt1lf"
			user = @current_user
			assigns(:user).should eq(user)
			response.should be_success
    end
	end

	describe "GET reset_password_data" do
    it "reset the user password using password token" do
			put :reset_password_data, {:token=> "COm3ZYP5hj1Q3stdt1lf", :password => "check", :password_confirmation => "check"}
			flash[:notice].should eql("password has been changed successfully")
			flash[:notice].should_not be_nil
			response.should redirect_to "/login"
    end
	end

	describe "GET reset_password_data wrong token" do
    it "reset the user password using wrong password token" do
			put :reset_password_data, {:token=> "wrongtoken", :password => "check", :password_confirmation => "check"}
			flash[:notice].should_not be_nil
			flash[:notice].should eql("user is not registered ")
			response.should redirect_to "/login"
    end
	end


end