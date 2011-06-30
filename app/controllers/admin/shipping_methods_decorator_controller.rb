Admin::ShippingMethodsController.class_eval do
include Admin::BaseHelper
 private
  def load_data
    @available_zones = Zone.where(:domain_url=>find_user_domain).order(:name)
    @calculators = ShippingMethod.calculators.sort_by(&:name)
  end
end
