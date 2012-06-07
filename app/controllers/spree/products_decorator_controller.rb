Spree::ProductsController.class_eval do
include Spree::Admin::BaseHelper
  def index
    p "222222222222222222222222222222222"
    @searcher = Spree::Config.searcher_class.new(params)
   p domain = get_sub_domain(current_subdomain)
    p @products = @searcher.retrieve_products(domain)
    p "3333333333333333333333"
		p	p=Spree::Product.find(:all,:conditions=>["domain_url=?",get_sub_domain(current_subdomain)],:order=>"id desc",:limit=>10).map(&:id)
    p @products
	  p #@products=@products.reject{|x| p.include?(x.id)}
    respond_with(@products)
  end
end
