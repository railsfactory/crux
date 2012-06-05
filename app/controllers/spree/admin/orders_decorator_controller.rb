Spree::Admin::OrdersController.class_eval do
  respond_to :html
  def index
   params[:q] ||= {}
        params[:q][:completed_at_not_null] ||= '1' if Spree::Config[:show_only_complete_orders_by_default]
        @show_only_completed = params[:q][:completed_at_not_null].present?
        params[:q][:meta_sort] ||= @show_only_completed ? 'completed_at.desc' : 'created_at.desc'

        if !params[:q][:created_at_gt].blank?
          params[:q][:created_at_gt] = Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day rescue ""
        end

        if !params[:q][:created_at_lt].blank?
          params[:q][:created_at_lt] = Time.zone.parse(params[:q][:created_at_lt]).end_of_day rescue ""
        end

        if @show_only_completed
          params[:q][:completed_at_gt] = params[:q].delete(:created_at_gt)
          params[:q][:completed_at_lt] = params[:q].delete(:created_at_lt)
        end

        @search =Spree::Order.ransack(params[:q])
				#@search=refine_list(@search)
        p @orders =Kaminari.paginate_array(refine_list(@search)).page(params[:page]).per(Spree::Config[:orders_per_page])
        
        respond_with(@orders)
  end

 def refine_list(orders)
    orders_arr = Spree::StoreownerOrder.find(:all,:conditions=>["store_owner_id = ?",current_user.store_owner.id]).map(&:order_id)
    order_collection=Spree::Order.find(:all,:conditions=>["id in (?) AND completed_at is NOT NULL",orders_arr])
    return order_collection
 end
end
