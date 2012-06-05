Spree::InventoryUnit.class_eval do
attr_accessible :variant, :state, :shipment
  def self.create_units(order, variant, sold, back_order)
  	domain=Spree::Product.find_by_id(variant.product_id).domain_url
		config=Spree::Configuration.find_by_name("Default configuration")
		pref=Spree::Preference.where("domain_url=? AND owner_type=?",domain,"Configuration")	
		if  pref.blank?
			back_order_val=Spree::Config[:allow_backorders]
		else
			back_order_val=pref.select{|x|x.name=="allow_backorders"}.map(&:value)[0]
		end			
		if back_order > 0 && !back_order_val
      raise "Cannot request back orders when backordering is disabled"
    end
    shipment = order.shipments.detect {|shipment| !shipment.shipped? }
    sold.times { order.inventory_units.create(:variant => variant, :state => "sold", :shipment => shipment) }
    back_order.times { order.inventory_units.create(:variant => variant, :state => "backordered", :shipment => shipment) }
  end

end
