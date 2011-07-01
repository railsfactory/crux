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
	validates :zipcode ,:presence =>{:message => "Please enter a zip code"},:numericality => { :message => "Please enter a valid zip code"},:allow_blank => true
	validates :card_type ,:presence =>{:message => "Please enter a card type"},:allow_blank => true
	validates :domain ,:presence =>{:message => "Please enter a domain name"},:uniqueness=>true,:format => { :with => /^[A-Za-z]+$/ },:allow_blank => true
	validates :phoneno,:presence =>{:message => "Please enter a phone no"},:allow_blank => true
	validates :name,:presence =>{:message => "Please enter a name"},:allow_blank => true
	#~ validates_credit_card :card_number, :card_type,:allow_blank => true
end
