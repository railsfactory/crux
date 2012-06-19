require 'spec_helper'
describe Spree::Product do

	it "should make only :name and :age attr_accessible" do
   Spree::Product.should_receive(:attr_accessible).with(:domain_url)
    load "#{Rails.root}/app/models/spree/product_decorator.rb"
  end 
	
	end