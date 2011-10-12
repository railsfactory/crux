Taxon.class_eval do

  def active_products(subdomain=nil)
    scope = self.products.active
		domain=subdomain.split(".")[0]
    stock_val=check_stock_value("show_zero_stock_products",domain)
    scope = scope.on_hand unless stock_val
    scope
  end

	def check_stock_value(attr,domain)
		config=Configuration.find_by_name("Default configuration")
		pref=Preference.where("domain_url=? AND owner_type=? AND owner_id=? ",domain,"Configuration",config.id)
		if  pref.blank?
			val=Spree::Config[:show_zero_stock_products]
		else
			val=pref.select{|x|x.name==attr}.map(&:value)[0]
	  end
		return val
	end
end
