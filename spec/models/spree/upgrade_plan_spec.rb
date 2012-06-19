require 'spec_helper'
describe Spree::UpgradePlan do

	it "should make only :name and :age attr_accessible" do
   Spree::UpgradePlan.should_receive(:attr_accessible).with(:domain_url)
    load "#{Rails.root}/app/models/spree/upgrade_plan.rb"
  end 
	
	end