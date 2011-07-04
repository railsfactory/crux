module StoresRegistrationHelper
def card_month
		[[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8],[9,9],[10,10],[11,11],[12,12] ]
end


def card_year
		[[2010,2010],[2011,2011],[2012,2012],[2013,2013],[2014,2014],[2015,2015],[2016,2016],[2017,2017],[2018,2018],[2019,2019],[2020,2020],[2021,2021],[2022,2022] ,[2023,2023] ,[2024,2024] ,[2025,2025]  ]
end
	def find_storename(domain)
		subdomain= domain.split(".") if domain
    storeowner=StoreOwner.find_by_domain(subdomain[0])
		@store=storeowner.bgcolor
	end
end
