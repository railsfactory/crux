module StoresRegistrationHelper
def card_month
		[[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8],[9,9],[10,10],[11,11],[12,12] ]
end

def card_year
		[[2018,2018] ]
	end
	
	def find_storename(domain)
		subdomain= domain.split(".") if domain
    storeowner=StoreOwner.find_by_domain(subdomain[0])
		@store=storeowner.bgcolor
	end
end
