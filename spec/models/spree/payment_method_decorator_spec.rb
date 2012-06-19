require 'spec_helper'
describe Spree::PaymentMethod do

	it "should make only :name and :age attr_accessible" do
   Spree::PaymentMethod.should_receive(:attr_accessible).with(:type,:domain_url)
    load "#{Rails.root}/app/models/spree/payment_method_decorator.rb"
  end 
	
	end