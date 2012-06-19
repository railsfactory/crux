require 'spec_helper'
describe Spree::UsersController , :type=>"controller" do
  include Devise::TestHelpers

  before(:each) do
    p 123
    @current_user = Factory(:valid_user)
    current_order = Factory(:valid_order)
    controller.stub!(:get_sub_domain).and_return("one")
    controller.stub!(:current_user).and_return(@current_user)
    controller.stub!(:load_account).and_return("one")
  end

	describe "GET show" do
		p 333
    it "should get view the show" do
			get :show
			response.should be_success
    end
	end

  describe "Post create" do
    it "should create a user " do
			post :create, {:user => {:email => "new@gmail.com", :password => "sample", :password_confirmation => "sample"}}
			response.should be_redirect
			#response.should be_success
    end
	end


  describe "GET edit" do
    it "should get view the edit" do
			get :edit
			response.should be_success
    end
	end

  describe "Post update" do
    it "should update a user " do
			post :update, {:user => { :email => "ram@gmail.com", :password => "sample", :password_confirmation => "sample"}, :domain_url => "one", :id => 1}
			response.should be_redirect
    end
	end

	describe "Post update" do
    it "should not allowed to update a user " do
			post :update, {:user => { :email => "ram@gmail.com", :password => "wrong", :password_confirmation => "sample"}, :domain_url => "one", :id => 1}
			response.should render_template("edit")
    end
	end

end