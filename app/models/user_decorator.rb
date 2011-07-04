User.class_eval do
	has_one :store_owner
  attr_accessible :domain_url
end