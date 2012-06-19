require 'spec_helper'
describe Spree::Order do
	    before(:each) do
			@order=Spree::Order.create()
      @product=Spree::Product.create(:domain_url=>"one")
		
	end
		it "should make only :name and :age attr_accessible" do
   Spree::Order.should_receive(:attr_accessible).with(:domain_url)
    load "#{Rails.root}/app/models/spree/order_decorator.rb"
  end 
		
	  context 'validation' do
			it "checks the method is valid or not" do
		domain= @order.products.first
  end
end

 context "valid?" do
    		 it "should be valid if it has an environment" do
      method = Spree::Order.new
      method.valid?.should be_true
    end
	end


	  context 'validation' do
			it "checks the method is valid or not" do
		@order=Spree::Order.new
  end
end
end