include Geokit::Geocoders
Spree::Address.class_eval do
validate :request_state_and_city_validation_based_on_zipcode, :if => :zipcode
 private
def request_state_and_city_validation_based_on_zipcode 
 poll = true # default true for new objects 
  if poll 
      loc = MultiGeocoder.geocode("#{self.zipcode},#{find_country_code}") 
  end # Add Validation Error if location is not found 
  unless loc.success 
    errors.add(:zipcode, " Unable to geocode your location from zipcode entered.") 
   else # Validate state and city fields in compare to loc object returned by geocode 
   errors.add(:country,"doesn't matches with zipcode entered") if find_country_code!=loc.country_code
	errors.add(:state, "doesn't matches with zipcode entered") if find_state_code != loc.state
   errors.add(:city, "doesn't matches with zipcode entered") if self.city != loc.city 
	  end 
  end 
 def find_country_code
self.country.id
Spree::Country.find_by_name(self.country)
Spree::Country.find_by_id(self.country.id).iso if Spree::Country.find_by_name(self.country)
 end
 def find_state_code
  Spree::State.find_by_id(self.state.id).abbr if  Spree::State.find_by_id(self.state)
end
  end