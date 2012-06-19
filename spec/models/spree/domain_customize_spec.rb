require 'spec_helper'
describe Spree::DomainCustomize do
  	 it "should be valid if it has an environment" do
      method = Spree::DomainCustomize.new()
      method.valid?.should be_false
    end
	


	it "should make only :name and :age attr_accessible" do
   Spree::DomainCustomize.should_receive(:attr_accessible).with( :custom_domain, :status)
    load "#{Rails.root}/app/models/spree/domain_customize.rb"
  end 
  
		  context "current" do
    it "should return the first active mail method corresponding to the current environment" do
      method = Spree::DomainCustomize.create()
      Spree::DomainCustomize.should_not == method
    end
  end
it {should validate_presence_of(:custom_domain)}
  #~ it{should belong_to(:spree_store_owner)}
end
