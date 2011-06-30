 Admin::ProductsController.class_eval do
  def load_data
    @tax_categories =TaxCategory.where("domain_url in (?)",find_user_domain).order(:name)
    @shipping_categories=ShippingCategory.where("domain_url in (?)",find_user_domain).order(:name)
  end
end
