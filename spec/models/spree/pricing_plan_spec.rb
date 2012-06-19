require 'spec_helper'
describe Spree::PricingPlan do
	
  #it{should belong_to(:store_owner)}
		it {should validate_presence_of(:plan_name)}
		it {should validate_presence_of(:no_of_products)}
		it {should validate_presence_of(:amount)}

  end