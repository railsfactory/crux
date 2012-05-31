Spree::ShippingMethod.class_eval do

  def self.all_available(order, display_on=nil, domain=nil)
    ship_domain=ShippingMethod.where(:domain_url=>domain)
    ship_domain.select { |method| method.available_to_order?(order,display_on)}
  end

end
