class StoreDetail < ActiveRecord::Base

		def self.store_details
			owners=StoreOwner.all
			owners.each do |owner|
				transaction_fee_amount=find_transaction_fee(owner)
				pricing_amount= pricing_plan_amount(owner)
				total_amounts=total_amount(transaction_fee_amount,pricing_amount)
				store_credit_details=credit_card(owner)
				store_bill_details=billing_address(owner)
				capture_amount=payment_response(owner,total_amounts,store_credit_details,store_bill_details)
			end
		end


		def self.find_transaction_fee(owner)
			price=owner.pricing_plan
			if owner && !owner.domain.blank?
					products=StoreDetail.where("domain_url=?",owner.domain).map(&:product_id).uniq
				if products && !products.empty?
					final_price=0
					products.each do |product|
						pro_quantity=StoreDetail.find_all_by_product_id(product).map(&:quantity).sum
						pro_id=Product.find_by_id(product)
						total_price=(pro_id.master.price*(price/100))*pro_quantity
						final_price=final_price+total_price
					end
				else
					final_price=0
				end
			  return final_price
		  end
		end

		def self.pricing_plan_transact_fee(owner)
			transaction_fee=owner.pricing_plan.transaction_fee
		end

		def self.pricing_plan_amount(owner)
			amount=owner.pricing_plan.amount
		end

		def self.total_amount(transaction_fee_amount,pricing_amount)
			amount=transaction_fee_amount+pricing_amount
		end


		def self.credit_card(owner)
			ActiveMerchant::Billing::CreditCard.new(
				:number =>owner.card_number,
				:type =>owner.card_type,
				:first_name =>owner.first_name,
				:last_name =>owner.last_name,
				:month => owner.expiration_month,
				:year =>owner.expiration_year,
				:verification_value =>owner.cvv
			)
		end

		def self.billing_address(owner)
			address=Hash.new
			address={ :name =>owner.name,
				:address1 =>owner.address1,
				:address2 =>owner.address2,
				:city =>owner.city,
				:state =>owner.state,
				:country =>owner.country,
				:zip =>owner.zipcode,
				:phone =>owner.phoneno}
		end


		def self.paypal_gateway	
			gateway = ActiveMerchant::Billing::PaypalGateway.new(:login =>APP_CONFIG['paypal_username'],:password =>APP_CONFIG['paypal_password'],:signature =>APP_CONFIG['paypal_signature'])
			return gateway
		end

		def self.payment_response(owner,total_amounts,store_credit_details,store_bill_details)
			authorize= paypal_gateway.authorize(total_amounts, store_credit_details,
			:ip => owner.ip,
			:billing_address =>store_bill_details
			)
			if authorize.params['ack']=="Success"
				response=paypal_gateway.capture(total_amounts, authorize.authorization)
				transaction_id=response.params['transaction_id']
				type="capture"
				acknowledge=response.params['ack']
				if acknowledge=="Success"
					update_billing(owner,transaction_id,type,acknowledge,total_amounts)
				else
					update_billing(owner,transaction_id,type,acknowledge,total_amounts)
					de_active(owner)
				end
			else
				transaction_id=0
				type="authorize"
				acknowledge=authorize.params['ack']
				update_billing(owner,transaction_id,type,acknowledge,total_amounts)
				de_active(owner)
			end
		end

		def self.de_active(owner)
			store=StoreOwner.find_by_id(owner.id)
			store.update_attribute(:is_active,false)
		end

		def self.update_billing(owner,transaction_id,type,acknowledge,total_amounts)
			billing_details=BillingHistory.create!(:store_owner_id=>owner.id,:amount=>total_amounts,:billing_date=>Date.today,:transaction_id=>transaction_id,:acknowledge=>acknowledge,:payment_type=>type)
		end

end
