require 'spec_helper'
describe Spree::Prototype do

	it "should make only :name and :age attr_accessible" do
   Spree::Prototype.should_receive(:attr_accessible).with(:domain_url)
    load "#{Rails.root}/app/models/spree/prototypes_decorator.rb"
  end 
	
	end