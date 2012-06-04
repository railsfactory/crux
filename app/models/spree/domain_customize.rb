module Spree
class DomainCustomize < ActiveRecord::Base
	 attr_accessible :custom_domain, :status
		belongs_to :store_owner
		validates :custom_domain, :presence => true,:uniqueness => true, :allow_blank=>true,:format =>{:with => /\A([^.\s]+).((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
end
end
