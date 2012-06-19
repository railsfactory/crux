require 'spec_helper'
describe Spree::UserPasswordsController, :type=>"controller" do
  include Devise::TestHelpers

  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = Factory(:valid_user)
    @current_order = Factory(:valid_order)
    controller.stub!(:get_sub_domain).and_return("one")
  end

	describe "GET new" do
    it "should view the new form" do
			get :new
			response.should be_success
    end
	end

  describe "Post create" do
    it "should create a reset password token " do
			post :create, {:user => {:email => "ram@gmail.com"}}
			#flash.now[:error].should eql("You are not a registered user of this site")
			response.should be_redirect
    end
	end

	describe "Post create" do
    it "should not allowed to create a reset password token " do
			post :create, {:user => {:email => "sam@gmail.com"}}
			flash.now[:error].should eql("You are not a registered user of this site")
			response.should render_template("new")
    end
	end

	describe "Get edit" do
    it "should view a the edit page" do
			get :edit
			response.should be_success
    end
	end

  describe "Post reset_password" do
    it "should create a user " do
			post :create, {:user => {:email => "new@gmail.com", :password => "wrong", :password_confirmation => "sample"}}
			response.should render_template('new')
			response.should be_success
    end
	end


end