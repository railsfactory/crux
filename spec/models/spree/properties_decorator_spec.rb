require 'spec_helper'
describe Spree::Property do

	it "should make only :name and :age attr_accessible" do
   Spree::Property.should_receive(:attr_accessible).with(:domain_url)
    load "#{Rails.root}/app/models/spree/properties_decorator.rb"
  end 
	
	end