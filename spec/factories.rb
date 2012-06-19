Factory.define :valid_user, :class => Spree::User do |u| 
  u.id 1
  u.password "123456"
  u.password_confirmation "123456"
  u.encrypted_password "030dba1f5480601f5abf7f884c027a4f96217b2103d586ba9cc..."
  u.password_salt "Ts2tSKaWquyKmWQNS9Yu"
  u.email "ram@gmail.com"
  u.remember_token nil
  u.persistence_token nil
  u.reset_password_token "COm3ZYP5hj1Q3stdt1lf"
  u.perishable_token nil
  u.sign_in_count 5
  u.failed_attempts 0
  u.last_request_at nil
  u.current_sign_in_at "2012-06-14 07:09:24"
  u.last_sign_in_at "2012-06-13 16:05:51"
  u.current_sign_in_ip "127.0.0.1"
  u.last_sign_in_ip "127.0.0.1"
  u.login "ram@gmail.com"
  u.ship_address_id nil
  u.bill_address_id nil
  u.created_at "2012-06-13 09:13:44"
  u.updated_at "2012-06-14 07:10:04"
  u.authentication_token nil
  u.unlock_token nil
  u.locked_at nil
  u.remember_created_at nil
  u.reset_password_sent_at "2012-06-14 07:08:58"
  u.api_key nil 
  u.is_owner nil 
  u.domain_url "one"
end

Factory.define :valid_order, :class => Spree::Order do |order|
  order.id 1069267068
  order.number "R563611266"
  order.item_total 12
  order.total 12000
  order.state "cart"
  order.adjustment_total 10000
  order.credit_total 10000
  order.user_id 1
  order.created_at "2012-06-15 10:33:23"
  order.updated_at "2012-06-15 10:33:23"
  order.completed_at nil
  order.bill_address_id nil
  order.ship_address_id nil
  order.payment_total 10000
  order.shipping_method_id nil
  order.shipment_state nil
  order.payment_state nil
  order.email "ram@gmail.com"
  order.special_instructions nil
end

Factory.define :plan1, :class => Spree::PricingPlan do |plan|
  plan.id 1 
  plan.plan_name "Basic"
  plan.amount 20.0
  plan.transaction_fee 3.0
  plan.no_of_products 15
  plan.payment_period "Monthly"
  plan.is_active true
  plan.created_at "2012-06-04 06:40:29"
  plan.updated_at "2012-06-04 06:40:29"
end

Factory.define :plan2, :class => Spree::PricingPlan do |plan|
  plan.id 2 
  plan.plan_name "Gold"
  plan.amount 100.0
  plan.transaction_fee 2.0
  plan.no_of_products 35
  plan.payment_period "Monthly"
  plan.is_active true
  plan.created_at "2012-06-04 06:40:29"
  plan.updated_at "2012-06-04 06:40:29"
end

Factory.define :plan3, :class => Spree::PricingPlan do |plan|
  plan.id 3 
  plan.plan_name "Silver"
  plan.amount 50.0
  plan.transaction_fee 2.5
  plan.no_of_products 25
  plan.payment_period "Monthly"
  plan.is_active true
  plan.created_at "2012-06-04 06:40:29"
  plan.updated_at "2012-06-04 06:40:29"
end

Factory.define :plan4, :class => Spree::PricingPlan do |plan|
  plan.id 4 
  plan.plan_name "Platinum"
  plan.amount 20.0
  plan.transaction_fee 1.0
  plan.no_of_products 45
  plan.payment_period "Monthly"
  plan.is_active true
  plan.created_at "2012-06-04 06:40:29"
  plan.updated_at "2012-06-04 06:40:29"
end

Factory.define :payment1, :class => Spree::StoreRegPaymentMethod do |payment|
  payment.id 1
  payment.username "railsf_1288590612_biz_api1.gmail.com"
  payment.password "1288590658"
  payment.signature "ApjKxcIa2WPQ5GZEF9Zbt2hKv7bxASAVpIVU6DMOwVTeEixqM2Z..."
  payment.created_at "2012-06-04 07:07:49"
  payment.updated_at "2012-06-04 07:07:49"
end

Factory.define :valid_country, :class => Spree::Country do |u| 
  u.id 1
  u.iso_name "UNITED STATES"
  u.iso "US"
  u.iso3 "USA"
  u.name "United States"
  u.numcode 840
end

Factory.define :valid_state, :class => Spree::State do |u| 
  u.id 1
  u.name "California"
  u.abbr "CA"
  u.country_id 1
end

Factory.define :valid_store_ower, :class => Spree::StoreOwner do |u| 
  u.id 1
  u.user_id 1
  u.first_name "siva"
  u.last_name "k"
  u.address1 "123 wall street"
  u.address2 "data"
  u.city "Los Angeles"
  u.zipcode "90001"
  u.state "California"
  u.country "United States"
  u.phone nil
  u.domain "one"
  u.card_number "4785636150538332"
  u.card_type "Visa"
  u.cvv "123"
  u.expiration_year "2023"
  u.expiration_month "8"
  u.pricing_plan_id 1
  u.ip "127.0.0.1"
  u.name "siva"
  u.phoneno 2147483647
  u.is_active 1
  u.	transaction_id "23A78876E771290"
  u.created_at "2012-06-13 09:13:44"
  u.updated_at "2012-06-14 07:10:04"
end


Factory.define :valid_product, :class => Spree::Product do |u| 
  u.id 1060500614
  u.name "cricket bat"
  u.description nil
  u.available_on "2012-06-15 00:00:00"
  u.	deleted_at nil
  u.permalink "cricket-bat"
  u.meta_description nil
  u.meta_keywords nil
  u.tax_category_id 	1
  u.shipping_category_id nil
  u.created_at "2012-06-13 09:13:44"
  u.updated_at "2012-06-14 07:10:04"
  u.count_on_hand 10
  u.domain_url "one"
  u.price 100
end
