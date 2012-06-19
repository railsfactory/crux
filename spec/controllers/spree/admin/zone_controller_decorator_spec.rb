require 'spec_helper'

describe   Spree::Admin::ZonesController,:type=>"controller" do
	#include Devise::TestHelpers
	describe " ZonesController" do
    def valid_attributes
      {:name=>"southxy", :description=>"tamilnadu123"
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
		describe "To get the index of the Zones controller" do
      it "should be successful" do
        get :index
        response.code.should == "200"
      end

    end
  end
end