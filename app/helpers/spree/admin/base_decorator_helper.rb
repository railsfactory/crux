module Spree
  module Admin
    module BaseDecoratorHelper
		#To find users domain
	def find_user_domain
		unless current_user.has_role?"admin"
			domain=current_user.domain_url
		else
			domain="admin"
		end
	end

	#To find the total transaction fee for the store owners
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

	 #To find the corressponding customized domain 
	def find_customization_domain
		customdomain=(request.url).split("/")[2]
		custom=DomainCustomize.find_by_custom_domain(customdomain)
	end

	#To find the corressponding sub domain
	def get_sub_domain(domain)
		if (request.url.include?(APP_CONFIG['separate_url']))
			subdomain= domain.split(".")[0] if domain
		elsif find_customization_domain
			store=StoreOwner.find_by_id(find_customization_domain.store_owner_id) 
			subdomain=store.domain
		end
		return subdomain
	end

	#To find  the number of products to restrict the store owner(Based on pricing plan)
	def products_count_checking(user)
		pricing_count=user.store_owner.pricing_plan.no_of_products
		products_count=Product.where(:domain_url=>user.domain_url,:deleted_at=>nil).length
		if pricing_count>products_count
			return true
		else
			return false
		end
	end

	#To find the preference for various settings

	def find_domain_preference(type)
		config=Configuration.find_by_name(type)
		if config
			available=Preference.find(:all,:conditions =>["domain_url=? AND owner_type=? AND owner_id=? ",get_sub_domain(current_subdomain),"Configuration",config.id])	
		else
			available=[]
		end
	end

end
end
end
