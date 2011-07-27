class SaasHooks < Spree::ThemeSupport::HookListener
  # custom hooks go here
Deface::Override.new(:virtual_path => "layouts/admin",
                     :name => "promo_admin_tabs",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :text => "<% if current_user.has_role?'storeowner' %>
										 <%= tab(:promotions) %> 
										 <%end%>",
                     :disabled => false)


Deface::Override.new(:virtual_path => "products/show",
                     :name => "promo_product_properties",
                     :insert_bottom => "[data-hook='product_properties'], #product_properties[data-hook]",
                     :partial => "products/promotions",
                     :disabled => false)

Deface::Override.new(:virtual_path => "checkout/_payment",
                     :name => "promo_coupon_code_field",
                     :replace => "[data-hook='coupon_code_field'], #coupon_code_field[data-hook]",
                     :partial => "checkout/coupon_code_field",
                     :disabled => false)

end