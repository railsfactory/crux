TaxonsController.class_eval do
	include Admin::BaseHelper
  def show
    @taxon = Taxon.find_by_permalink!(params[:id])
    return unless @taxon
    @searcher = Spree::Config.searcher_class.new(params.merge(:taxon => @taxon.id))
    domain = get_sub_domain(current_subdomain)
    @products = @searcher.retrieve_products(domain)

    respond_with(@taxon)
  end
end
