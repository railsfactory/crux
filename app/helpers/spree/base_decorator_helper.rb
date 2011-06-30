module Spree::BaseHelper
def find_domain_preference(type)
  domain= current_subdomain.split(".")[0]
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
     subdomain= domain.split(".") if domain
    currentdomain =(subdomain&&subdomain.length >0) ? subdomain[0] : nil
    taxon=Taxon.roots.where('domain_url= ?',currentdomain)
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
	end
end

end
