Spree::BaseController.class_eval do
    include Spree::Core::ControllerHelpers
  include Spree::Core::RespondWith
 before_filter :load_account,:set_current_subdomain
 
 def set_current_subdomain
      p current_subdomain =  request.subdomain.blank? ? "cruxloc" : request.subdomain
     end
end
