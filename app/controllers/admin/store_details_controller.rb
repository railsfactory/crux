class Admin::StoreDetailsController < Admin::ResourceController
  resource_controller

   def index
    @store_owners=StoreOwner.all.paginate(:per_page => Spree::Config[:admin_products_per_page], :page => params[:page])
    @store_details=StoreDetail.all
    if request.xhr?
   @owner=StoreOwner.find_by_domain(params[:domain])
   @plan=@owner.pricing_plan
      #~ StoreDetail.find_all_by_domain_url(params[:domain])
    products_id=StoreDetail.find_all_by_domain_url(params[:domain]).map(&:product_id).uniq
    @product_name=[]
    @pro_quantity=[]
    @total_price=[]
products_id.each do |product|
 product_details=Product.find_by_id(product)
 @product_name<<product_details.name
 quantity=StoreDetail.find_all_by_product_id(product).map(&:quantity).sum
  @pro_quantity<<quantity
  @total_price<<(product_details.master.price*(@plan.transaction_fee/100))*quantity
 end

      render :partial=>"product_details"
     end
  end

   def new
   end

   def create
   end

   def edit
   end

   def delete
   end

end
