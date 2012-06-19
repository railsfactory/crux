require 'spec_helper'
describe Spree::OptionType do

	it "should make only :name and :age attr_accessible" do
   Spree::OptionType.should_receive(:attr_accessible).with(:domain_url)
    load "#{Rails.root}/app/models/spree/option_types_decorator.rb"
  end 
	
	end