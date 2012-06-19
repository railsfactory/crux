require 'spec_helper'

describe   Spree::Admin::PaymentMethodsController,:type=>"controller" do
	#include Devise::TestHelpers
	describe "PaymentMethodsController" do
    def valid_attributes
      {:type=>"Spree::nitin::Bogus",
        :name=> "Credit Card",
        :description=>"this is new Bogus payment gateway for development."
      }
    end

    def mock_user(stubs={})
      @mock_user ||= mock_model(Spree::User, stubs).as_null_object
    end
    before(:each) do
      controller.stub!(:check_http_authorization).and_return(true)
      controller.stub!(:load_account).and_return("one")
      request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
      @current_user = 1
      controller.stub!(:get_sub_domain).and_return("one")
    end
		describe "To get the index of the PaymentMethods Controller" do
      it "should be successful" do

        post :create,:payment_method=>{:type=>"Spree::Gateway::Bogus",
          :name=> "Credit Card",
          :description=>"this is new Bogus payment gateway for development."},:domain_url=>"one"
        response.should be_true
      end

    end
    describe "To get the store registration method" do
      it "should be successful" do

        get :store_registration_payment_method,:store_reg_payment_method=>{:username=>"sedin", :password=>"sedin123"},:domain_url=>"one"
        response.should be_success
      end

    end



  end
end