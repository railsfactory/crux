Spree::Variant.class_eval do
  def available?
		domain=Spree::Product.find_by_id(self.product_id).domain_url
		back_order_val=check_value("allow_backorders",domain)
    Spree::Config[:track_inventory_levels] ? (back_order_val|| self.in_stock?) : true
  end

  def check_value(attr,domain)
		config=Spree::Configuration.find_by_name("Default configuration")
		pref=Spree::Preference.where("domain_url=? AND owner_type=? AND owner_id=? ",domain,"Configuration",config.id)
		if  pref.blank?
			val=Spree::Config[:allow_backorders]
		else
			val=pref.select{|x|x.name==attr}.map(&:value)[0]
		end
		return val
  end
end