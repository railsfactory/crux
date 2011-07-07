class DomainCustomize < ActiveRecord::Base
belongs_to :store_owner
validates :custom_domain, :presence => true,:uniqueness => true, :allow_blank=>true
end
