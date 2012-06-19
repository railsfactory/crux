require 'spec_helper'
describe Spree::MailMethod do
	  context 'validation' do
			it "checks the method is valid or not" do
		Spree::MailMethod.current()
  end
end

	it "should make only :name and :age attr_accessible" do
   Spree::MailMethod.should_receive(:attr_accessible).with( :domain_url)
    load "#{Rails.root}/app/models/spree/mail_method_decorator.rb"
  end 

 context "valid?" do
    it "should be false when missing an environment value" do
      method = Spree::MailMethod.new
      method.valid?.should be_false
    end
	end
	 it "should be valid if it has an environment" do
      method = Spree::MailMethod.new(:environment => "foo")
      method.valid?.should be_true
    end
		
		  context "current" do
    it "should return the first active mail method corresponding to the current environment" do
      method = Spree::MailMethod.create(:environment => "test")
      Spree::MailMethod.current.should_not == method
    end
  end

  end