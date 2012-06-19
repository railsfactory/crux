require 'spec_helper'
describe Spree::Zone do

	it "should make only :name and :age attr_accessible" do
   Spree::Zone.should_receive(:attr_accessible).with(:domain_url)
    load "#{Rails.root}/app/models/spree/zone_decorator.rb"
  end 
	
	end