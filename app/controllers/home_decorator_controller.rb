HomeController.class_eval do
	include Admin::BaseHelper
  def index
    @searcher = Spree::Config.searcher_class.new(params)
		 domain = get_sub_domain(current_subdomain)
    @products = @searcher.retrieve_products(domain)
    respond_with(@products)
  end
end
