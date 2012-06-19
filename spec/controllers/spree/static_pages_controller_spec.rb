
require 'spec_helper'

describe   Spree::StaticPagesController,:type=>"controller" do
  #include Devise::TestHelpers
  describe " StaticPagesController" do
    def mock_user(stubs={})
      @mock_user ||= mock_model(Spree::User, stubs).as_null_object
    end
    before(:each) do
      controller.stub!(:check_http_authorization).and_return(true)
      request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
      @current_user = 1
      controller.stub!(:get_sub_domain).and_return("one")
      controller.stub!(:load_account).and_return("one")
    end
    it "should get before_filtered for authenticate_jobseeker!" do
      controller.stub!(:check_http_authorization).and_return(true)
    end

    describe "To get the index of the products controller" do
      it "should be successful" do


        get :aboutus
        response.should be_success

      end
      it "should be successful" do


        get :contactus
        response.should be_success

      end
      it "should be successful" do


        get :privacy
        response.should be_success

      end
      it "should be successful" do


        get :terms
        response.should be_success

      end

    end

  end
end
