require 'spec_helper'

describe Spree::Variant do
	
 it "creates the inventory create_units"do
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