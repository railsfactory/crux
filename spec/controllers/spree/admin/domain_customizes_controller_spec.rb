require 'spec_helper'
describe Spree::Admin::DomainCustomizesController ,:type=>"controller" do
	def mock_user(stubs={})
		@mock_user ||= mock_model(Spree::User, stubs).as_null_object
	end


	def valid_attributes
    {
      :store_owner_id=>1,
      :custom_domain=>"siva",
      :status=>1,
      :created_at =>"2012-06-13 09:13:44",
      :updated_at =>"2012-06-14 07:10:04"
    }
	end

	before(:each) do
		request.env['warden'] = mock(Warden, :authenticate => mock_user,:authenticate! => mock_user)
		@current_user = Factory(:valid_user)
		@country = Factory(:valid_country)
		@state = Factory(:valid_state)
		@store = Factory(:valid_store_ower)
		controller.stub!(:load_account).and_return("one")
		controller.stub!(:current_user).and_return(@current_user)
		controller.stub!(:find_user_domain).and_return("cruxloc")
	end

	#~ describe "Get index" do
  #~ it "should be successful" do
  #~ controller.stub!(:get_sub_domain).and_return("siva")
  #~ get:index
  #~ response.should be_success
  #~ end
	#~ end

	describe "Get new" do
    it "should be successful" do
			controller.stub!(:get_sub_domain).and_return("one")
			get:new
      response.should be_true
		end
	end

	#~ describe "POST create" do
  #~ it "should be successful" do
  #~ controller.stub!(:get_sub_domain).and_return("siva")
  #~ post:create, {:domain => valid_attributes}
  #~ response.should be_success
  #~ end
	#~ end

	describe "GET edit" do
    it "should be successful" do
			controller.stub!(:get_sub_domain).and_return("one")
			get:edit
			response.should be_true
		end
	end


	describe "PUT update" do
    it "should be successful" do
			controller.stub!(:get_sub_domain).and_return("one")
			put:update, {:domain => valid_attributes}
			response.should be_true
		end
	end

end