class StoreownerOrder < ActiveRecord::Base
	belongs_to :store_owner
	belongs_to :order
end
