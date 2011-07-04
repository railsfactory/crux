class StoreownerOrder < ActiveRecord::Base
	belongs_to :store_owner
	belongs_to :order
	scope :store_val, lambda {|s| where('store_owner_id = ?', s)}.map(&:order_id)		
end
