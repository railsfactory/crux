class Admin::DomainCustomizesController  < Admin::ResourceController
  resource_controller
   before_filter :find_domain_customize, :only => [:edit, :update]
  def index
    @domain_customize=DomainCustomize.find_by_store_owner_id(current_user.store_owner.id)
  end

  def new
    @domain_customize=DomainCustomize.new
  end

  def create
        @domain_customize=current_user.store_owners.build(params[:store_owners])
        if @domain_customize.save
          redirect_to(admin_domain_customizes_path(@domain_customize), :notice => 'domain was successfully created.')
          else
                    flash[:error] =  @domain_customize.errors.full_messages
                    render  "new"
            end
  end

  def edit
      end

  def update
      if @domain_customize.update_attributes(params[:domain_customize])
       redirect_to(admin_domain_customizes_path(@domain_customize), :notice => 'domain was successfully updated.')
      else
        flash[:error] =  @domain_customize.errors.full_messages
        render  "edit"
      end
    end
  def find_domain_customize
     @domain_customize=DomainCustomize.find(params[:id])
    end
end
