require 'spec_helper'

describe Spree::Admin::TaxonsController , :type => "controller" do

	def mock_user(stubs={})
		@mock_user ||= mock_model(Spree::User, stubs).as_null_object
	end

	before(:each) do
    controller.stub!(:check_http_authorization).and_return(true)
    controller.stub!(:respond_with).and_return(true)
    taxonomy = Spree::Taxonomy.create(:name => "RailsFactory")
    request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
		@current_user = 1
		controller.stub!(:load_account).and_return("one")
		controller.stub!(:get_sub_domain).and_return("one")
	end

	describe "POST create" do
    it "user To create a Taxonomy" do
	    taxonomy = Spree::Taxonomy.create(:name => "RailsFactory")
			taxon=Spree::Taxon.create(:taxonomy_id=>taxonomy.to_param,:name=>"sedin")
			#post :create, {:taxonomy_id=>taxonomy.to_param,:taxon=>{:name=>"nitin"}}
			response.should be_true
    end
  end





end

