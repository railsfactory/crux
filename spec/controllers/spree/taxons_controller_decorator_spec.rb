require 'spec_helper'

describe   Spree::TaxonsController,:type=>"controller" do
  #include Devise::TestHelpers
  describe " TaxsonsController" do
    def valid_attributes
      {

        :name=>"railscfactory",
        :permalink=>"railsfactory"

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
    it "should get before_filtered for authenticate_jobseeker!" do
      controller.stub!(:check_http_authorization).and_return(true)
    end

    describe "To get the index of the products controller" do

      it "should get the products" do
        Spree::Taxon.create! valid_attributes
        get :show
        response.code.should
      end
    end

  end
end
