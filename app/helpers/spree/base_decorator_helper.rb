module Spree::BaseHelper
def find_domain_preference(type)
  domain= get_sub_domain(current_subdomain)
	config=Configuration.find_by_name(type)
  available=Preference.where("domain_url=? AND owner_type=? AND owner_id=? ",domain,"Configuration",config.id)	
	return available
	end
def find_stock_value(attr)
	pref=find_domain_preference("Default configuration")
	if  pref.blank?
		if attr=="show_zero_stock_products"
		val=Spree::Config[:show_zero_stock_products]
		elsif attr=="allow_backorders"
			val=Spree::Config[:allow_backorders]
		end	
	else
  val=pref.find_by_name(attr).value
end
  return val
end
  def get_taxons(domain)
     subdomain= get_sub_domain(domain)
		taxon=Taxon.roots.where('domain_url= ?',subdomain)
	end
	
	
	def find_storeowner_email(order)
		domain=find_mail_domain(order)
		store_owner=StoreOwner.find_by_domain(domain)
		store_owner=store_owner.user.email
	end

	
def find_mail_domain(order)
		store=StoreownerOrder.find_by_order_id(order.id)

	mail_domain=store.store_owner.domain
end

def mail_settings(domain)
	mail_methods=MailMethod.find_all_by_domain_url(domain)
	unless mail_methods.blank?
		Spree::MailSettings.init(domain)
		Mail.register_interceptor(MailDomainInterceptor)
		return true
		else
			return false
	end
end
def get_sub_domain(domain)
    if (request.url.include?(APP_CONFIG['separate_url']))
     subdomain= domain.split(".")[0] if domain

     else
			
			 
store=StoreOwner.find_by_id(find_customization_domain.store_owner_id) 
       subdomain=store.domain
       #~ custom_domain= domain.split(".") if domain
       #~ store=StoreOwner.find_by_custom_domain(domain)
       #~ subdomain=store.domain
     end
       return subdomain
   end

def find_customization_domain
	customdomain=(request.url).split("/")[2]
	custom=DomainCustomize.find_by_custom_domain(customdomain)
	
end
def find_digital_domain(order)
store=StoreownerOrder.find_by_order_id(order.id)
if store.is_custom?
return store.store_owner.domain_customize.custom_domain
else
return store.store_owner.domain+"."+APP_CONFIG['separate_url']+"."+APP_CONFIG['domain_url'].split(".").last
end
end

  def star(the_class) 
    "<span class=\"#{the_class}\"> &#10030; </span>"
  end

  def mk_stars(m)
    (1..5).collect {|n| n <= m ? star("lit") : star("unlit") }.join
  end
  
  def txt_stars(n, show_out_of = true)
    res = I18n.t('star', :count => n)
    res += ' ' + t('out_of_5') if show_out_of
    res
  end

end
