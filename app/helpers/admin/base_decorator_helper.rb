module Admin::BaseHelper
def find_user_domain
		unless current_user.has_role?"admin"
	domain=current_user.domain_url
	else
	domain="admin"
	end
	end
 def find_transaction_fee(owner)
 
if owner && !owner.domain.blank?
  products=StoreDetail.where("domain_url=?",owner.domain).map(&:product_id).uniq
    if products && !products.empty?
			final_price=0
      products.each do |product|
       pro_quantity=StoreDetail.find_all_by_product_id(product).map(&:quantity).sum
       pro_id=Product.find_by_id(product)
       total_price=(pro_id.master.price*(owner.pricing_plan.transaction_fee/100))*pro_quantity
       final_price=final_price+total_price
       end
		 end
	return final_price
  end

end
   def get_sub_domain(subdomain)
		  if (request.url.include?(APP_CONFIG['separate_url'])) 
    domain= subdomain.split(".")[0]
		else
			
			custom_domain= subdomain.split(".") if subdomain
       custom=DomainCustomize.find_by_custom_domain(custom_domain)
			 if custom
			 store=StoreOwner.find_by_id(custom.store_owner_id)
       domain=store.domain
			 else
				 domain=""
			 end
			 end
    return domain
	end
		
		
	def find_domain_preference(type)
  domain=get_sub_domain(current_subdomain)
	config=Configuration.find_by_name(type)
  available=Preference.where("domain_url=? AND owner_type=? AND owner_id=? ",domain,"Configuration",config.id)	
	return available
	end


end
