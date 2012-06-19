require 'spec_helper'
describe Spree::CheckoutController ,:type=>"controller" do
  include Devise::TestHelpers

  def mock_user(stubs={})
    @mock_user ||= mock_model(Spree::User, stubs).as_null_object
  end


  before(:each) do
    request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
    @current_user = Factory(:valid_user)
    @current_order = Factory(:valid_order)
    controller.stub!(:load_account).and_return("one")
    session[:order_id] = @current_order.id
    #~ session[:user_id] = @current_user.id
    #~ UserSession.create! (@current_user)
    #~ let(:current_order) { Factory :valid_order }
    #~ p current_user
    #~ p current_order
    controller.stub!(:get_sub_domain).and_return("one")
  end

	describe "GET reset_password" do
    it "find the user using the password token" do
			post :update, {:domain_url => "one"}

			#~ get :reset_password,:token=> "COm3ZYP5hj1Q3stdt1lf"
			#~ user = @current_user
			#~ assigns(:user).should eq(user)
			response.should be_true
    end
	end

	#~ describe "GET reset_password_data" do
  #~ it "reset the user password using password token" do
  #~ get :reset_password_data, {:token=> "COm3ZYP5hj1Q3stdt1lf", :password => "check", :password_confirmation => "check"}
  #~ flash[:notice].should eql("password has been changed successfully")
  #~ flash[:notice].should_not be_nil
  #~ response.should redirect_to "/login"
  #~ end
	#~ end

	#~ describe "GET reset_password_data wrong token" do
  #~ it "reset the user password using wrong password token" do
  #~ get :reset_password_data, {:token=> "wrongtoken", :password => "check", :password_confirmation => "check"}
  #~ flash[:notice].should_not be_nil
  #~ flash[:notice].should eql("user is not registered")
  #~ response.should redirect_to "/login"
  #~ end
	#~ end


end