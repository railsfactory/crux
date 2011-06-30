class Admin::DomainCustomizesController  < Admin::ResourceController
  resource_controller

  
  def index
    @domain_customize=DomainCustomize.find_by_store_owner_id(current_user.store_owner.id)
  end

  def new
    @domain_customize=DomainCustomize.new
  end

  def create
        @domain_customize=DomainCustomize.new(params[:domain_customize])
        @domain_customize.store_owner_id=current_user.store_owner.id
        if @domain_customize.save
          redirect_to(admin_domain_customizes_path(@domain_customize), :notice => 'domain was successfully created.') 
          else
                    flash[:error] =  @domain_customize.errors.full_messages
                    render  "new"
            end
  end

  def edit
         @domain_customize=DomainCustomize.find(params[:id])
      end

  def update
         @domain_customize=DomainCustomize.find(params[:id])

      if @domain_customize.update_attributes(params[:domain_customize])
       redirect_to(admin_domain_customizes_path(@domain_customize), :notice => 'domain was successfully updated.') 
      else
        flash[:error] =  @domain_customize.errors.full_messages
        render  "edit"
        
      end
    
    
  end

end
