Spree::UserRegistrationsController.class_eval do
 #~ include SpreeBase
  #~ helper :users, 'spree/base'
  ssl_required
  after_filter :associate_user, :only => :create
  before_filter :check_permissions, :only => [:edit, :update]
  skip_before_filter :require_no_authentication
 layout "home"
end