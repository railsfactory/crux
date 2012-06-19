require 'spec_helper'
describe Spree::Taxonomy do

	it "should make only :name and :age attr_accessible" do
   Spree::Taxonomy.should_receive(:attr_accessible).with(:domain_url)
    load "#{Rails.root}/app/models/spree/taxonomies_decorator.rb"
  end 
	
	end