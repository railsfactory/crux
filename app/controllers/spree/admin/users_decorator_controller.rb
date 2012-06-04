Spree::Admin::UsersController.class_eval do
  helper :all
  def collection
    return @collection if @collection.present?
    unless request.xhr?
      if current_user.nil?
        @collection=[]
      else
        @search = Spree::User.registered.search(params[:q])
        @collection = Kaminari.paginate_array(refine_list(@search)).page(params[:page]).per(Spree::Config[:admin_products_per_page])
      end
    else
      @collection = Spree::User.includes(:bill_address => [:state, :country], :ship_address => [:state, :country]).where("users.email like :search
                                                                                                         OR addresses.firstname like :search
                                                                                                                OR addresses.lastname like :search
                                                                                                                OR ship_addresses_users.firstname like :search
                                                                                                                OR ship_addresses_users.lastname like :search",
                                                                                                                         {:search => "#{params[:q].strip}%"}).limit(params[:limit] || 100)
    end
  end



  def refine_list(collection)
    unless current_user.has_role? "admin"
    users_arr = Spree::User.find(:all,:conditions=>["domain_url = ? AND is_owner is NULL",current_user.domain_url]).map(&:id)
    else
      users_arr=Spree::User.find(:all,:conditions=>["is_owner = ?","1"]).map(&:id)
    end
    if !collection.blank?
       #users_collection=collection.find("id in (?)",users_arr)
      users_collection=Spree::User.find(:all,:conditions=>["id in (?)",users_arr])
    else
      users_collection=[]
    end
    return users_collection
  end

  def store_owners
    if request.xhr?
      store=Spree::StoreOwner.find_by_id(params[:userid])
      if store.is_active?
        store.update_attribute(:is_active,false)
      else
        store.update_attribute(:is_active,true)
      end
      render:update do |page|
        @users=Spree::User.where('is_owner=?',1)
        page.reload
      end
    end
  end

  def load_roles
    roles = Spree::Role.all
    @roles = roles.select{|x| x.name=="user"}
  end

end
