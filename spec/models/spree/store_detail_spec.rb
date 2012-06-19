require 'spec_helper'
describe Spree::StoreDetail do

	it "should make only :name and :age attr_accessible" do
   Spree::StoreDetail.should_receive(:attr_accessible).with(:product_id, :quantity, :domain_url)
    load "#{Rails.root}/app/models/spree/store_detail.rb"
  end 
	
	end