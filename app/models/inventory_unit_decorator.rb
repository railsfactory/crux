InventoryUnit.class_eval do

  def self.create_units(order, variant, sold, back_order)
  	domain=Product.find_by_id(variant.product_id).domain_url
			config=Configuration.find_by_name("Default configuration")
			pref=Preference.where("domain_url=? AND owner_type=? AND owner_id=? ",domain,"Configuration",config.id)	
			if  pref.blank?
				back_order_val=Spree::Config[:allow_backorders]
			else
			back_order_val=pref.find_by_name("allow_backorders").value
		end			
		
    if back_order > 0 && !back_order_val
      raise "Cannot request back orders when backordering is disabled"
    end

    shipment = order.shipments.detect {|shipment| !shipment.shipped? }

    sold.times { order.inventory_units.create(:variant => variant, :state => "sold", :shipment => shipment) }
    back_order.times { order.inventory_units.create(:variant => variant, :state => "backordered", :shipment => shipment) }
  end
  
end
