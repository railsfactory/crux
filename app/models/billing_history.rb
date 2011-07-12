class BillingHistory < ActiveRecord::Base
	attr_accessible :type,:store_owner_id,:amount,:billing_date,:transaction_id,:acknowledge,:payment_type,:message
	belongs_to :store_owner
	end
