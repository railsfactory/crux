Spree::BaseController.class_eval do
    include Spree::Core::ControllerHelpers
  include Spree::Core::RespondWith
 before_filter :load_account
end
