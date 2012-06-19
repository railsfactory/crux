require 'spec_helper'
describe Spree::Promotion do
	    before(:each) do
	@promotion=Spree::Promotion.new(:description=>"dsfdsfdsfdsfds",:name=>"dsfdsfds")
    end

 context "valid?" do
    		 it "should be valid if it has an environment" do
      method = Spree::Promotion.new
      method.valid?.should be_false
    end
	end
	
	it "check the eligible mehod" do
		@owner_order=Spree::StoreownerOrder.create(:store_owner_id=>1,:order_id=>1069267035)
		@owner_order.store_owner

		end
		
		  context "current" do
    it "should return the first active mail method corresponding to the current environment" do
      method = Spree::Promotion.create(:description=>"dsfdsfdsfdsfds",:name=>"dsfdsfds")
      @promotion.should_not == method
    end
  end
end