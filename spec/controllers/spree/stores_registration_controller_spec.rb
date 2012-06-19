require 'spec_helper'
describe Spree::StoresRegistrationController, :type=>"controller" do
  include Devise::TestHelpers

  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = Factory(:valid_user)
    Factory(:plan1)
    Factory(:plan2)
    Factory(:plan3)
    Factory(:plan4)
    Factory(:payment1)
    current_order = Factory(:valid_order)
    controller.stub!(:get_sub_domain).and_return("one")
    controller.stub!(:current_subdomain).and_return("one.cruxloc")
    controller.stub!(:current_user).and_return(@current_user)
    controller.stub!(:load_account).and_return("one")
    session[:plan] = 1
    Factory(:valid_country)
    Factory(:valid_state)
  end

	describe "GET index" do
    it "should get view the index page" do
			get :index
      plans = Spree::PricingPlan.all
			assigns(:plans) =~ (plans)
			response.should be_success
    end
	end


  describe "GET new_store" do
    it "should get view the new_store page" do
			get :new_store, {:id => 1}
			response.should be_success
    end
	end

	describe "post save_store_details" do
    it "should not allowed to create a store and user" do
			post :save_store_details, {"user"=>{"email"=>"", "password"=>"", "password_confirmation"=>""}, "store_owner"=>{"name"=>"", "address1"=>"", "address2"=>"", "city"=>"", "zipcode"=>"", "country"=>"United States", "state"=>"California", "phoneno"=>"", "domain"=>"", "first_name"=>"", "last_name"=>"", "card_number"=>"", "card_type"=>"Visa", "cvv"=>"", "expiration_year"=>"2010", "expiration_month"=>"1"}, "x"=>"72", "y"=>"8"}
			response.should render_template("new_store")
    end
	end

  describe "post save_store_details" do
    it "should show payment error" do
			post :save_store_details, {"user"=>{"email"=>"shiva.sms65@gmail.com", "password"=>"123456", "password_confirmation"=>"123456"}, "store_owner"=>{"name"=>"siva", "address1"=>"perumal mudhali street", "address2"=>"royapettah", "city"=>"Los Angeles", "zipcode"=>"90001", "country"=>"United States", "state"=>"California", "phoneno"=>"9994134766", "domain"=>"siva", "first_name"=>"siva", "last_name"=>"kumar", "card_number"=>"4785636150538332","card_type"=>"Visa", "cvv"=>"123", "expiration_year"=>"2020", "expiration_month"=>"4"}, "x"=>"76", "y"=>"19"}
			flash[:error].should eql("Payment could not be processed,please check your details")
    end
	end

	describe "GET storeowner" do
    it "should the store" do
			get :storeowner, {:user_id => 1}
			response.should be_redirect
    end
	end


end