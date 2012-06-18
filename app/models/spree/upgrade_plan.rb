module Spree
  class UpgradePlan < ActiveRecord::Base
    attr_accessible :domain_url
    attr_accessible :store_owner_id, :plan_id
  end
end
