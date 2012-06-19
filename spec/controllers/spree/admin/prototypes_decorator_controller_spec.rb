require 'spec_helper'
describe Spree::Admin::PrototypesController,:type=>"controller" do
  include Devise::TestHelpers
  def valid_attributes
    {
			:name=>"railsfactory"
    }
  end
  def mock_user(stubs={})
    @mock_user ||= mock_model(Spree::User, stubs).as_null_object
  end
  before(:each) do
    controller.stub!(:load_account).and_return("one")
    request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
    @current_user = 1
    controller.stub!(:get_sub_domain).and_return("one")
  end


end
