Spree::Admin::ProductsController.class_eval do
 def load_data
  p "2222222222222222222222222222222"
  @tax_categories =Spree::TaxCategory.where("domain_url in (?)",find_user_domain).order(:name)
  @shipping_categories=Spree::ShippingCategory.where("domain_url in (?)",find_user_domain).order(:name)
 end
end
