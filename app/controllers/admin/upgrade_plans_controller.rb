class Admin::UpgradePlansController < Admin::ResourceController
  resource_controller

	def index
		plan=current_user.store_owner.pricing_plan_id
		@pricing_plans=PricingPlan.find(:all,:conditions=>['is_active=? and id !=?',true,plan])
	end
	
	def user_update_plan
		user=	current_user.store_owner
		user.update_attribute(:pricing_plan_id,params[:plan_id])
		flash[:notice]="Your plan has been upgraded successfully"
		upgrade=UpgradePlan.create(:store_owner_id=>user.id,:plan_id=>user.pricing_plan_id)
		upgrade.save		
		redirect_to admin_upgrade_plans_path
	end		

#~ def paypal_gateway	
		   #~ gateway = ActiveMerchant::Billing::PaypalGateway.new(:login =>APP_CONFIG['paypal_username'],:password =>APP_CONFIG['paypal_password'],:signature =>APP_CONFIG['paypal_signature'])
		#~ return gateway
	#~ end
	
	
#~ def credit_card
		#~ ActiveMerchant::Billing::CreditCard.new(
	#~ :type =>  user.card_type,
	#~ :first_name =>user.first_name,
	#~ :last_name =>user.last_name,
	#~ :number => user.card_number,
	#~ :month =>  user.expiration_month,
	#~ :year => user.expiration_year,
	#~ :verification_value => user.cvv
	#~ )
#~ end

#~ def payment_response	
	#~ authorize= paypal_gateway.authorize(@amount, credit_card,:ip => request.remote_ip,:billing_address =>billing_address)
	 #~ if authorize.success?
		#~ @response=paypal_gateway.capture(@amount, authorize.authorization)
		 #~ if @response.success?
				#~ user.update_attributes(:pricing_plan_id=>params[:plan_id])
		   #~ flash[:store_notice] = "Your plan has been upgradedS successfully"
		#~ else
		 #~ flash[:error]= "Payment failed could not be processed,please check your details"
		 #~ render  ""
		 #~ end
	#~ else
	 #~ flash[:error]= "Payment failed could not be processed,please check your details"
	 #~ render  "new_store"
	#~ end
#~ end

end
