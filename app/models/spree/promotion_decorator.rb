Spree::Promotion.class_eval do
#Overriding eligible? method to identify the domain
 def eligible?(order)
		if order
			store=StoreownerOrder.find_by_order_id(order.id).store_owner
			if self.domain_url == store.domain
				!expired? && rules_are_eligible?(order)
			else
				return false
			end
		end
  end

end