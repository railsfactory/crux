Spree::Admin::ShippingMethodsController.class_eval do
 include Spree::Admin::BaseHelper

 def load_data
  p "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  p @available_zones = Spree::Zone.where(:domain_url=>find_user_domain).order(:name)
  @calculators = Spree::ShippingMethod.calculators.sort_by(&:name)
 end
end
