User.class_eval do
	has_one :store_owner
  attr_accessible :domain_url
  scope :user_val, lambda {|u| where("domain_url = ? AND is_owner is NULL", u)}
	  scope :users_val,:conditions=>["is_owner = ?","1"]
end