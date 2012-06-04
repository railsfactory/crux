Spree::Order.class_eval do
   attr_accessible :domain_url
  attr_accessible :store_owner_id, :order_id, :is_custom
  def available_shipping_methods(display_on = nil)
    return [] unless ship_address
    Spree::ShippingMethod.all_available(self, display_on,find_order_domain)
  end

  def find_order_domain
    domain=self.products.first.domain_url
    return domain
  end

  def available_payment_methods
    @available_payment_methods||= Spree::PaymentMethod.where("domain_url=?",find_order_domain).available(:front_end)
  end

  def payment_method
    if payment and payment.payment_method
      payment.payment_method
    else
      available_payment_methods.first
    end
  end
end
