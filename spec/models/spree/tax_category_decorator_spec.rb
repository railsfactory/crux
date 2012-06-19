require 'spec_helper'
describe Spree::TaxCategory do

	it "should make only :name and :age attr_accessible" do
   Spree::TaxCategory.should_receive(:attr_accessible).with(:domain_url)
    load "#{Rails.root}/app/models/spree/tax_category_decorator.rb"
  end 
	
	end