require 'spec_helper'
describe Spree::BillingHistory do
before(:each) do
@user=Spree::BillingHistory.new()
end

	it "should make only :name and :age attr_accessible" do
   Spree::BillingHistory.should_receive(:attr_accessible).with( :type,:store_owner_id,:amount,:billing_date,:transaction_id,:acknowledge,:payment_type,:message)
    load "#{Rails.root}/app/models/spree/billing_history.rb"
  end 
  
	 it "should be valid if it has an environment" do
      method = Spree::BillingHistory.new()
      method.valid?.should be_true
    end
		
		  context "current" do
    it "should return the first active mail method corresponding to the current environment" do
      method = Spree::BillingHistory.create()
      Spree::BillingHistory.should_not == method
    end
  end
  context 'validation' do
   # it { should belong_to(:spree_store_owner) }
  end

  end
