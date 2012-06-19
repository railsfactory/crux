require 'spec_helper'
describe Spree::Preference do

	it "should make only :name and :age attr_accessible" do
   Spree::Preference.should_receive(:attr_accessible).with(:owner_type, :domain_url)
    load "#{Rails.root}/app/models/spree/preference_decorator.rb"
  end 
	
	end