module Spree
class StoreRegPaymentMethod < ActiveRecord::Base
	attr_accessible :password,:username,:signature
		validates :username, :presence =>true,:allow_blank=>true
		validates :password, :presence =>true,:allow_blank=>true
		validates :signature, :presence =>true,:allow_blank=>true
end
end
