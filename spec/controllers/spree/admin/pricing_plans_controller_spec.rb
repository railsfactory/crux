require 'spec_helper'

describe   Spree::Admin::PricingPlansController,:type=>"controller" do
	#include Devise::TestHelpers
	describe "PricingPlansController" do
    def valid_attributes
      {:plan_name=>"hello",
        :amount=>"120",
        :transaction_fee=>"130",
        :no_of_products=>"3",
        :payment_period=>"Monthly"

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
		describe "To get the index of the PricingPlans Controller" do
      it "should be successful" do


        p Spree::PricingPlan.create! valid_attributes
        get :index
        response.should be_success
      end

    end
    describe "To get the index of the PricingPlans Controller" do
      it "should be successful" do


        p Spree::PricingPlan.create! valid_attributes
        get :show
        response.should be_redirect
      end

    end
  end
end