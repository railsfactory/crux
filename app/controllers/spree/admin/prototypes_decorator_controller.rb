Spree::Admin::PrototypesController.class_eval do
  def available
    domain=find_user_domain
    @prototypes = Spree::Prototype.where(:domain_url=>domain).order('name asc')
    respond_to do |wants|
      wants.html { render :layout => !request.xhr? }
    end
  end
end

