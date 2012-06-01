Spree::Admin::ShippingMethodsController.class_eval do
 include Spree::Admin::BaseHelper
 private
 def load_data
  @available_zones = Spree::Zone.where(:domain_url=>find_user_domain).order(:name)
  @calculators = Spree::ShippingMethod.calculators.sort_by(&:name)
 end
end
