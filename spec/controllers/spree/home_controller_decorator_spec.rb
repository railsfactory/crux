require 'spec_helper'
describe Spree::HomeController ,:type=>"controller" do
  include Devise::TestHelpers

  def mock_user(stubs={})
    @mock_user ||= mock_model(Spree::User, stubs).as_null_object
  end

  before(:each) do
    request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
    controller.stub!(:get_sub_domain).and_return("one")
    controller.stub!(:load_account).and_return("one")
    p @products=Factory(:valid_product)
    controller.stub!(:respond_with).and_return(@products)
    @current_user = {:id => 1}
  end

  describe "GET index" do
    it "assigns the OrderStoresComments as @comments" do
      respond_with(@products)
			response.should be_success
    end
  end
end