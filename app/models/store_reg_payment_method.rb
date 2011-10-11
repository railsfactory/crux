class StoreRegPaymentMethod < ActiveRecord::Base
		validates :username, :presence =>true,:allow_blank=>true
		validates :password, :presence =>true,:allow_blank=>true
		validates :signature, :presence =>true,:allow_blank=>true
end
