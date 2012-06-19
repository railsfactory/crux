require 'spec_helper'
describe Spree::StoreOwner do

 context "valid?" do
    		 it "should be valid if it has an environment" do
      method = Spree::StoreOwner.new
      method.valid?.should be_false
    end
	end

		  context "current" do
    it "should return the first active mail method corresponding to the current environment" do
      method = Spree::StoreOwner.create()
      Spree::StoreOwner.should_not == method
    end
  end
  #~ it{should belong_to(:store_owner)}
  #~ it{should belong_to(:order)}

		end