require 'spec_helper'
describe Spree::InventoryUnit do
   before(:each) do
@product=Spree::Product.create(:id=> 4545434,:name=>"abc", :description=> "",:domain_url=> "one")

end

	it "should make only :name and :age attr_accessible" do
   Spree::InventoryUnit.should_receive(:attr_accessible).with( :variant, :state, :shipment)
    load "#{Rails.root}/app/models/spree/inventory_unit_decorator.rb"
  end 
	
	
	 it "should be valid if it has an environment" do
      method = Spree::InventoryUnit.new()
      method.valid?.should be_true
    end
		
		  context "current" do
    it "should return the first active mail method corresponding to the current environment" do
      method = Spree::InventoryUnit.create()
      Spree::InventoryUnit.should_not == method
    end
  end

it "creates the inventory create_units"do
 @product.domain_url
config=Spree::Configuration.find_by_name("Default configuration")
pref=Spree::Preference.where("domain_url=? AND owner_type=?","one","Configuration")	

if  pref.should be_empty
			back_order_val=Spree::Config["allow_backorders"]
				else	
			back_order_val=pref.select{|x|x.name=="allow_backorders"}.map(&:value)[0]
		end	
		 back_order=0
			if back_order.should ==0
				      "Cannot request back orders when backordering is disabled"
    end
  end
  end
