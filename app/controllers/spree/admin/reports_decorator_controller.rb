Spree::Admin::ReportsController.class_eval do
 def sales_total
    params[:search] = {} unless params[:search]
    if params[:search][:created_at_greater_than].blank?
      params[:search][:created_at_greater_than] = Time.zone.now.beginning_of_month
    else
      params[:search][:created_at_greater_than] = Time.zone.parse(params[:search][:created_at_greater_than]).beginning_of_day rescue Time.zone.now.beginning_of_month
    end
    if params[:search] && !params[:search][:created_at_less_than].blank?
      params[:search][:created_at_less_than] = Time.zone.parse(params[:search][:created_at_less_than]).end_of_day rescue ""
    end
    if params[:search].delete(:completed_at_is_not_null) == "1"
      params[:search][:completed_at_is_not_null] = true
    else
      params[:search][:completed_at_is_not_null] = false
    end
    params[:search][:meta_sort] ||= "created_at.desc"
    @search = Order.metasearch(params[:search])
    @orders = @search
    unless current_user.has_role?"admin"
      store=current_user.store_owner
      orders=store.storeowner_orders.map(&:order_id)
      @item_total = @search.where("id in (?)",orders).sum(:item_total)
      @adjustment_total = @search.where("id in (?)",orders).sum(:adjustment_total)
      puts @search.where("id in (?)",orders).map(&:adjustment_total)
      puts @search.where("id in (?)",orders).map(&:created_at)
      @sales_total = @search.where("id in (?)",orders).sum(:total)
    else
      @item_total = @search.sum(:item_total)
      @adjustment_total = @search.sum(:adjustment_total)
      @sales_total = @search.sum(:total)
    end
  end
end
