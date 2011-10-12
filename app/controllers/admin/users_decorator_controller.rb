Admin::UsersController.class_eval do
  helper :users
	def collection
		return @collection if @collection.present?
		unless request.xhr?
			@search = User.registered.metasearch(params[:search])
			@collection = refine_list(@search).paginate(:per_page => Spree::Config[:admin_products_per_page], :page => params[:page])
		else
			@collection = User.includes(:bill_address => [:state, :country], :ship_address => [:state, :country]).where("users.email like :search
													 OR addresses.firstname like :search
														OR addresses.lastname like :search
														OR ship_addresses_users.firstname like :search
														OR ship_addresses_users.lastname like :search",
														{:search => "#{params[:q].strip}%"}).limit(params[:limit] || 100)
		end
	end

  def refine_list(collection)
		unless current_user.has_role? "admin"
			users_arr = User.find(:all,:conditions=>["domain_url = ? AND is_owner is NULL",current_user.domain_url]).map(&:id)
		else
				users_arr=User.find(:all,:conditions=>["is_owner = ?","1"]).map(&:id)
		end
		users_collection=collection.where("id in (?)",users_arr)
	 return users_collection
  end

  def store_owners
		if request.xhr?
		store=StoreOwner.find_by_id(params[:userid])
			if store.is_active?
					store.update_attribute(:is_active,false)
			else
					store.update_attribute(:is_active,true)
			end
			render:update do |page|
					@users=User.where('is_owner=?',1)
					page.reload
			end
  	end
  end

  def load_roles
		roles = Role.all
		@roles = roles.select{|x| x.name=="user"}
	end

end