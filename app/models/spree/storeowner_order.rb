module Spree
  class StoreownerOrder < ActiveRecord::Base
    attr_accessible:store_owner_id, :order_id, :is_custom
		belongs_to :store_owner
		belongs_to :order
  end
end
