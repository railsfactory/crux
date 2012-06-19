require 'spec_helper'
describe Spree::StoreOwner do

  #it{should belong_to(:store_owner)}
	#~ it { should have_one(:domain_customize) }
  #~ it { should have_one(:pricing_plan) }
  #~ it { should have_many(:storeowner_orders) }
  #~ it { should have_many(:transactions) }
  #~ it { should have_many(:billing_histories) }

     #~ it {should have_many(:spree_storeowner_orders) }
		#~ it {should have_one(:spree_pricing_plan) }
	#it { should be_accessible :first_name }
	
	it "should make only :name and :age attr_accessible" do
   Spree::StoreOwner.should_receive(:attr_accessible).with(:first_name,:last_name,:card_number,:cvv,:card_type,:domain,:phoneno,:name,:address1,:address2,:city,:card_number,:zipcode,:country, :state, :expiration_year, :expiration_month)
    load "#{Rails.root}/app/models/spree/store_owner.rb"
  end 
	
	it 'first_name should be accessible' do

owner = Spree::StoreOwner.new

owner.first_name = "asdf"

owner.first_name.should == "asdf"
end

		context "shoulda validations" do
			
			it {should validate_presence_of(:first_name).with_message("First name cant be blank") }
			it {should validate_presence_of(:last_name).with_message("Last name cant be blank") }
						
			it {should validate_presence_of(:card_number).with_message("Please enter a card number") }
			it {should validate_presence_of(:cvv).with_message("Please enter a CVV code") }
						
			it {should validate_presence_of(:card_type).with_message("Please enter a card type") }
			it {should validate_presence_of(:domain).with_message("Please enter a domain name") }
						
			it {should validate_presence_of(:phoneno).with_message("Please enter a phone no") }
			it {should validate_presence_of(:name).with_message("Please enter a name") }
						
			it {should validate_presence_of(:address1).with_message("Please enter a  Address 1") }
   			it {should validate_presence_of(:address2).with_message("Please enter a Address 2") }
						
			it {should validate_presence_of(:city).with_message("Please enter a city") }
			it {should validate_presence_of(:card_number).with_message("please enter a card number") }
						
			it {should validate_presence_of(:cvv).with_message("please enter a cvv") }
			it {should validate_presence_of(:zipcode).with_message("Please enter a Zip code") }
				
      end

		it "find_country_code" do
        Spree::Country.find_by_name("Zimbabwe")
		end	
			it "ind_state_code" do
      Spree::State.find_by_name('ram')
   	end	

  
  end