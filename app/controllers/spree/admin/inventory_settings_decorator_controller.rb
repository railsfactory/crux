Spree::Admin::InventorySettingsController.class_eval do 
  def update
    #~ Spree::Config.set(params[:preferences])
	   pre=Spree::Preference.find_all_by_domain_url(params[:preferences][:domain_url])
	   config=Spree::Configuration.find_by_name("Default configuration")
		  pre=Spree::Preference.where("domain_url=? AND owner_type=? AND owner_id=?",params[:preferences][:domain_url],"Configuration",config.id)	
    if pre.blank?
      preference=Spree::Preference.create(:name=>"show_zero_stock_products",:owner_id=>config.id,:owner_type=>"Configuration",:value=>params[:preferences][:show_zero_stock_products],:domain_url=> params[:preferences][:domain_url])
      preference=Spree::Preference.create(:name=>"allow_backorders",:owner_id=>config.id,:owner_type=>"Configuration",:value=>params[:preferences][:allow_backorders],:domain_url=>params[:preferences][:domain_url])
      preference.save
    else
      pre.each do |p|
        p.value= params[:preferences][:show_zero_stock_products] if p.name=="show_zero_stock_products"
        p.value= params[:preferences][:allow_backorders] if p.name=="allow_backorders"
        p.save
      end
    end
    respond_to do |format|
      format.html {
        redirect_to admin_inventory_settings_path
      }
    end
  end
end
