require 'spec_helper'
describe Spree::StoreRegPaymentMethod do
	
	 it "should be valid if it has an environment" do
      method = Spree::StoreRegPaymentMethod.new()
      method.valid?.should be_false
    end
		
		context "current" do
    it "should return the first active mail method corresponding to the current environment" do
      method = Spree::StoreRegPaymentMethod.create()
      Spree::StoreRegPaymentMethod.should_not == method
    end
    end
			it {should validate_presence_of(:username) }
   		it {should validate_presence_of(:password) }
			it {should validate_presence_of(:signature) }
   
						

  
  end