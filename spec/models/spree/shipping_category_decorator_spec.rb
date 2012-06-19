require 'spec_helper'
describe Spree::ShippingCategory do

	it "should make only :name and :age attr_accessible" do
   Spree::ShippingCategory.should_receive(:attr_accessible).with(:domain_url)
    load "#{Rails.root}/app/models/spree/shipping_category_decorator.rb"
  end 
	
	end