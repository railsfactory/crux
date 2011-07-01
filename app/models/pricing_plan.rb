class PricingPlan < ActiveRecord::Base
belongs_to :store_owner
validates :plan_name, :presence => true,:uniqueness => true, :format => { :with => /^[A-Za-z ]+$/ },:allow_blank=>true
validates :no_of_products, :presence=> true,:allow_blank=> true,:numericality=> {:only_integer=> true ,:greater_than=> 0}
validates :amount, :presence => true,:numericality => {:greater_than => 0},:allow_blank=>true				
end


