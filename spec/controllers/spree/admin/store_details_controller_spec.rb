require 'spec_helper'

describe   Spree::Admin::StoreDetailsController,:type=>"controller" do
	#include Devise::TestHelpers
	describe "StoreDetailsController" do
    def valid_attributes
      {:domain_url=>"hello", :quantity=>"3",
        :product_name=>"nitin",
        :product_price=>"143",
        :pro_quantity=>"1"

      }
    end

    def mock_user(stubs={})
      @mock_user ||= mock_model(Spree::User, stubs).as_null_object
    end
    before(:each) do
      controller.stub!(:check_http_authorization).and_return(true)
      request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
      @current_user = 1
      controller.stub!(:load_account).and_return("one")
      controller.stub!(:get_sub_domain).and_return("one")
    end
		describe "To get the index of the Zones controller" do
      it "should be successful" do


        get :index
        response.code.should == "200"
      end

    end
  end
end