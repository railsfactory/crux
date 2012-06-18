Spree::User.class_eval do

	has_one :store_owner
  attr_accessible :domain_url



  #validation for crux
  #~ validates_presence_of   :email, :if => :email_required?
  #~ validates_uniqueness_of :email, :scope => :domain_url
  #~ with_options :if => :password_required? do |v|
  #~ v.validates_presence_of     :password
  #~ v.validates_confirmation_of :password
  #~ v.validates_length_of       :password, :within => 6...20, :allow_blank => true
  #~ end
  protected

  def email_required?
    true
  end



  #~ def self.find_for_authentication(conditions={})
  #~ unless $domain_value_url.blank?
  #~ conditions[:domain_url]=$domain_value_url
  #~ end
  #~ filter_auth_params(conditions)
  #~ (case_insensitive_keys || []).each { |k| conditions[k].try(:downcase!) }
  #~ to_adapter.find_first(conditions)
  #~ end
  private

  # Generate a token by looping and ensuring does not already exist.



end

