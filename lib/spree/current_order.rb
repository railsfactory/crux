module Spree
  module CurrentOrder
    # This should be overridden by an auth-related extension which would then have the
    # opportunity to associate the new order with the # current user before saving.
    def before_save_new_order
    end

    # This should be overridden by an auth-related extension which would then have the
    # opporutnity to store tokens, etc. in the session # after saving.
    def after_save_new_order
    end

    # The current incomplete order from the session for use in cart and during checkout
    def current_order(create_order_if_necessary = false)
      return @current_order if @current_order
      if session[:order_id]
        @current_order = Order.find_by_id(session[:order_id], :include => :adjustments)
      end
      if create_order_if_necessary and (@current_order.nil? or @current_order.completed?)
        @current_order = Order.new
        before_save_new_order
        @current_order.save!
         if request.url.include?(APP_CONFIG['separate_url'])
                     				subdomain = current_subdomain.split(".")[0]

           else

              custom_subdomain=current_subdomain.split(".")[0]
            custom_domain_collect=DomainCustomize.find_by_custom_domain(custom_subdomain)
         
            custom_domain=StoreOwner.find_by_id(custom_domain_collect.store_owner_id)
            subdomain=custom_domain.domain
             end
				store=StoreOwner.find_by_domain(subdomain)
			   store_owner=StoreownerOrder.new(:store_owner_id=>store.id,:order_id=>@current_order.id)
			   store_owner.save
        after_save_new_order
      end
      session[:order_id] = @current_order ? @current_order.id : nil
      @current_order
    end
  end
end
