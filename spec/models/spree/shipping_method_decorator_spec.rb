require 'spec_helper'
describe Spree::ShippingMethod do
	    before(:each) do
	@promotion=Spree::ShippingMethod.new(:domain_url=>"one")
    end

 context "valid?" do
    		 it "should be valid if it has an environment" do
      method = Spree::ShippingMethod.new
      method.valid?.should be_false
    end
	end
	
	it "finds the domain_url" do
		@promotion.domain_url
	end

		  context "current" do
    it "should return the first active mail method corresponding to the current environment" do
      method = Spree::ShippingMethod.create()
      @promotion.should_not == method
    end
  end
end