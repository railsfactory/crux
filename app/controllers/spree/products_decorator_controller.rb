Spree::ProductsController.class_eval do
include Spree::Admin::BaseHelper
  def index
    p "222222222222222222222222222222222"
    @searcher = Spree::Config.searcher_class.new(params)
   domain = get_sub_domain(current_subdomain)
     @products = @searcher.retrieve_products(domain)

		Spree::Product.find(:all,:conditions=>["domain_url=?",get_sub_domain(current_subdomain)],:order=>"id desc",:limit=>10).map(&:id)
     
	   #@products=@products.reject{|x| p.include?(x.id)}
    respond_with(@products= Kaminari.paginate_array(@products).page(params[:page]).per(6))
  end
end
