Spree::TaxonsController.class_eval do
	include Spree::Admin::BaseHelper
  def show
    params[:id]
    @taxon = Spree::Taxon.find_by_permalink!(params[:id])
    return unless @taxon

    @searcher = Spree::Config.searcher_class.new(params.merge(:taxon => @taxon.id))
    domain = get_sub_domain(current_subdomain)
    @test = @searcher.retrieve_products(domain)
    @products = Kaminari.paginate_array(@test).page(params[:page]).per(6)
    respond_with(@taxon)
  end
end
