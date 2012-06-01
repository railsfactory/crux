class Spree::Admin::StoreDetailsController <Spree::Admin::ResourceController
  #~ resource_controller
  def index
    @store_owners=Spree::StoreOwner.all.paginate(:per_page => Spree::Config[:admin_products_per_page], :page => params[:page])
    @store_details=Spree::StoreDetail.all
    if request.xhr?
      @owner=Spree::StoreOwner.find_by_domain(params[:domain])
      @plan=@owner.pricing_plan
      products_id=Spree::StoreDetail.find_all_by_domain_url(params[:domain]).map(&:product_id).uniq
      @product_name=[]
      @product_price=[]
      @pro_quantity=[]
      @total_price=[]
      products_id.each do |product|
        product_details=Spree::Product.find_by_id(product)
        @product_name<<product_details.name
        @product_price<<product_details.master.price
        puts @product_price.inspect
        quantity=Spre::StoreDetail.find_all_by_product_id(product).map(&:quantity).sum
        @pro_quantity<<quantity
        @total_price<<(product_details.master.price*(@plan.transaction_fee/100))*quantity
      end
      render :partial=>"product_details", :locals => { :owner => @owner,:product_name=>@product_name,:product_price=>@product_price,:pro_quantity=>@pro_quantity,:total_price=>@total_price,:plan=>@plan }
    end
  end
  def store_billing
   @store_owner=current_user.store_owner
   unless @store_owner.billing_histories.blank?
    @billing_histories=@store_owner.billing_histories
   end
  end
  def billing_history
   if request.xhr?
    store_owner=Spree::StoreOwner.find_by_id(params[:store], :include => :billing_histories)
    billing_histories=store_owner.billing_histories
    render :partial=>"billing_history", :locals => { :owner => store_owner,:billings=>billing_histories}
   end
  end
end
