Spree::Admin::TaxonsController.class_eval do
  include Spree::Admin::BaseHelper
  def create
    @taxonomy = Taxonomy.find(params[:taxonomy_id])
    @taxon = @taxonomy.taxons.build(params[:taxon])
    @taxon.domain_url=@taxonomy.domain_url
    if @taxon.save
      respond_with(@taxon) do |format|
        format.json {render :json => @taxon.to_json }
      end
    else
      flash[:error] = I18n.t('errors.messages.could_not_create_taxon')
      respond_with(@taxon) do |format|
        format.html { redirect_to @taxonomy ? edit_admin_taxonomy_url(@taxonomy) : admin_taxonomies_url }
      end
    end
  end
	
  def available
    @product = load_product
    @taxons = params[:q].blank? ? [] : Taxon.where('lower(name) LIKE ? AND domain_url=?', "%#{params[:q].mb_chars.downcase}%",find_user_domain)
    @taxons.delete_if { |taxon| @product.taxons.include?(taxon) }
    respond_with(:admin, @taxons)
  end

  def load_product
    Product.find_by_permalink! params[:product_id]
  end

end
