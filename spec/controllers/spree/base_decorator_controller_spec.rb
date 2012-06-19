require 'spec_helper'
describe Spree::BaseController ,:type=>"controller" do
  include Devise::TestHelpers

  def mock_user(stubs={})
    @mock_user ||= mock_model(Spree::User, stubs).as_null_object
  end

  before(:each) do
    request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
    @current_user = Factory(:valid_user)
  end

	describe "GET base_decorator_controller" do
    it "should receive the load_account function" do
      controller.should_not_receive(:load_account)
    end
	end



end