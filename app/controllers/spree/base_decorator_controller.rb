Spree::BaseController.class_eval do
  include SpreeRespondWith
  include SpreeBase
  before_filter :load_account
end
