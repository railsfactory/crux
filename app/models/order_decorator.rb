Order.class_eval do
  def available_shipping_methods(display_on = nil)
    return [] unless ship_address
    ShippingMethod.all_available(self, display_on,find_order_domain)
  end

  def find_order_domain
    domain=self.products.first.domain_url
    return domain
  end

  def available_payment_methods
    @available_payment_methods||= PaymentMethod.where("domain_url=?",find_order_domain).available(:front_end)
  end

  def payment_method
    if payment and payment.payment_method
      payment.payment_method
    else
      available_payment_methods.first
    end
  end
end
