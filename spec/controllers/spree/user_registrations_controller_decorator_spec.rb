require 'spec_helper'
describe Spree::UserRegistrationsController ,:type=>"controller" do
  include Devise::TestHelpers

	before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = Factory(:valid_user)
    @current_order = Factory(:valid_order)
    session[:order_id] = @current_order.id
    #~ controller.stub!(:current_user).and_return(@current_user)
  end


	describe "GET new" do
    it "should be response new" do
			get :new
			response.should be_success
    end
	end

	describe "GET create" do
    it "should be create a new user" do
			post :create, {:user => {:email => "new@gmail.com", :password => "sample", :password_confirmation => "sample"}}
			flash[:notice].should eql("Welcome! You have signed up successfully.")
    end
	end

	describe "GET create" do
    it "should not allowed to create a user" do
			post :create, {:email => "new@gmail.com", :password => "wrong", :password_confirmation => "sample"}
			response.should be_success
    end
	end

	describe "GET edit" do
    it "should not allowed to view the edit page" do
			get :edit, {:id => 1}
			response.should_not be_success
    end
	end

  describe "GET destroy" do
    it "should not be destroy the user" do
			delete :destroy
			response.should_not be_success
    end
	end

	#~ describe "GET cancel" do
  #~ it "should be Cancel the user" do
  #~ get :cancel
  #~ response.should_not be_success
  #~ end
	#~ end


end