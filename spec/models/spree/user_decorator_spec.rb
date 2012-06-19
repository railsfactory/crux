require 'spec_helper'
describe Spree::User do
  
	it "should make only :name and :age attr_accessible" do
   Spree::User.should_receive(:attr_accessible).with(:domain_url)
    load "#{Rails.root}/app/models/spree/user_decorator.rb"
  end 
	
  context 'validation' do
  #  it { should have_one(:spree_store_owner) }
  end

  end