include Geokit::Geocoders
class StoreOwner < ActiveRecord::Base
	has_one :domain_customize
	has_one :pricing_plan
	has_many :storeowner_orders
	has_many :transactions
	has_many :billing_histories
	belongs_to :user
	belongs_to :pricing_plan
	validates :first_name, :presence => {:message=>"First name cant be blank"},:format => { :with => /^[A-Za-z ]+$/ },:allow_blank=>true
	validates :last_name, :presence =>  {:message=>"Last name cant be blank"},:format => { :with => /^[A-Za-z ]+$/ },:allow_blank=>true
	validates :card_number,:presence =>{:message => "Please enter a card number"},:allow_blank => true
	validates :cvv,:presence =>{:message => "Please enter a CVV code"},:format => { :with => /^[0-9]+$/,:message => "Please enter a valid CVV code"},:allow_blank=>true
	validates :card_type ,:presence =>{:message => "Please enter a card type"},:allow_blank => true
	validates :domain ,:presence =>{:message => "Please enter a domain name"},:uniqueness=>true,:format => { :with => /^[A-Za-z]+$/ },:allow_blank => true
	validates :phoneno,:presence =>{:message => "Please enter a phone no"},:allow_blank => true
	validates :name,:presence =>{:message => "Please enter a name"},:allow_blank => true
	validates :address1, :presence => {:message=>"Please enter a  Address 1"}
	validates :address2, :presence => {:message=>"Please enter a Address 2"}
	validates :city, :presence => true,:format => { :with => /^[A-Za-z ]+$/ },:allow_blank=>true
	validates :card_number, :presence => {:message=>"please enter a card number"},:numericality => { :message=>"please enter a valid number"},:allow_blank=>true
	validates :cvv, :presence => {:message=>"please enter a cvv"},:numericality => { :message=>"please enter a valid cvv"},:allow_blank=>true
	#~ validates_credit_card :card_number, :card_type,:allow_blank => true
	validates_presence_of :zipcode 
	validate :request_state_and_city_validation_based_on_zipcode, :if => :zipcode
	
def request_state_and_city_validation_based_on_zipcode 
poll = true # default true for new objects 
if poll 
	loc = MultiGeocoder.geocode("#{self.zipcode},#{find_country_code}") 
	end # Add Validation Error if location is not found 
		unless loc.success 
errors.add(:zipcode, " Unable to geocode your location from zipcode entered.") 
	else # Validate state and city fields in compare to loc object returned by geocode 
		errors.add(:country," doesn't matches with zipcode entered") if find_country_code!=loc.country
errors.add(:state, " doesn't matches with zipcode entered") if find_state_code != loc.state


errors.add(:city, " doesn't matches with zipcode entered") if self.city != loc.city 
	
		end 
		end 
	end
	
def find_country_code
	Country.find_by_name(self.country).iso
end

def find_state_code
	State.find_by_name(self.state).abbr
end