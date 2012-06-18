class Spree::StoresRegistrationController < Spree::BaseController
	#~ include Spree::Base
	before_filter :load_account
	ActiveMerchant::Billing::Base.mode = :test
	include ActiveMerchant::Billing
	layout 'spree/layouts/saas'
	def paypal_gateway
		gateway = ActiveMerchant::Billing::PaypalGateway.new(:login =>@payment.username,:password =>@payment.password,:signature =>@payment.signature)
		return gateway
	end

	def index
  	@plans = Spree::PricingPlan.find(:all,:conditions=>"is_active=true")
	end

	def pricing_plan(id)
		plan=Spree::PricingPlan.find_by_id(id)
	end

	def new_store
	  if Spree::StoreRegPaymentMethod && Spree::StoreRegPaymentMethod.first
			@user = Spree::User.new()
			@store_owner = Spree::StoreOwner.new()
			session[:plan] = params[:id]
			plan=pricing_plan(params[:id])
			@plan_name=plan.plan_name
			@amount=plan.amount
	  else
			flash[:notice]="No Payment Methods available"
			redirect_to "#{APP_CONFIG['domain_url']}"
		end
	end

	def save_store_details
		plan=pricing_plan(session[:plan])
		@plan_name=plan.plan_name
		@amount= Spree::PricingPlan.find_by_id(session[:plan]).amount
		@user = Spree::User.new(params[:user])
		@store_owner = @user.build_store_owner(params[:store_owner])
		@store_owner.pricing_plan_id = session[:plan]
		@user.valid?
		@store_owner.valid?
		if @user.valid? && @store_owner.valid?
			payment_response
		else
			render  "new_store"
		end
	end

	def after_sign_in_path_for(resource)
		if resource.is_a?(Spree::User) && resource.is_owner?
			flash.notice = I18n.t("logged_in_succesfully")
			admin_url(:subdomain =>resource.store_owner.domain + ".#{APP_CONFIG['separate_url']}")
		else
			super
		end
	end

	def storeowner
		@user = Spree::User.find_by_id(params[:user_id])
		sign_in_and_redirect(:user,@user)
	end

	def credit_card
		ActiveMerchant::Billing::CreditCard.new(:type =>  params[:store_owner][:card_type],:first_name => params[:store_owner][:first_name],:last_name => params[:store_owner][:last_name],
      :number =>  params[:store_owner][:card_number],
      :month =>  params[:store_owner][:expiration_month],
      :year =>  params[:store_owner][:expiration_year],
      :verification_value => params[:store_owner][:cvv]
	  )
	end

	def billing_address
	  address=Hash.new
	  address={ :name => params[:store_owner][:name],
      :address1 => params[:store_owner][:address1],
      :address2 =>params[:store_owner][:address2],
      :city =>params[:store_owner][:city],
      :state => params[:store_owner][:state],
      :country => params[:store_owner][:country],
      :zip => params[:store_owner][:zipcode],
      :phone => params[:store_owner][:phoneno]}
	end

	def payment_response
    @payment=Spree::StoreRegPaymentMethod && Spree::StoreRegPaymentMethod.first ? Spree::StoreRegPaymentMethod.first : []
		unless @payment.blank?
  	  authorize= paypal_gateway.authorize((@amount*100).round, credit_card,:ip => request.remote_ip,:billing_address =>billing_address)
		  if authorize.success?
        @response=paypal_gateway.capture((@amount* 100).round, authorize.authorization)
				if @response.success?
					@user.is_owner = true
					@user.domain_url = params[:store_owner][:domain]
					@user.roles << Spree::Role.find_by_name('storeowner')
					@user.save
					mail_method=Spree::MailMethod.find_all_by_domain_url('admin').first
					unless mail_method.blank?
						Spree::StoreRegisterMailer.register_email(mail_method,@user.email).deliver
					end
					@store_owner.transaction_id=	@response.params['transaction_id']
					@store_owner.ip=request.remote_ip
					@store_owner.save
					billing_history(@response.params['transaction_id'],@amount,@store_owner.id,authorize.params['ack'],"Completed")
					flash[:store_notice] = "Your Store has been registered successfully"
					current_user = @user
					redirect_to storeowner_url(:subdomain=>"#{@user.domain_url}.#{APP_CONFIG['separate_url']}",:user_id=>@user.id)
				else
					flash[:error]= "Payment could not be processed,please check your details"
					render  "new_store"
				end
		  else
			  flash[:error]= "Payment could not be processed,please check your details"
			  render  "new_store"
		  end
		end
	end

	def billing_history(transaction_id,total_amounts,owner,acknowledge,message)
		Spree::BillingHistory.create!(:store_owner_id=>owner,:amount=>total_amounts,:billing_date=>Date.today,:transaction_id=>transaction_id,:acknowledge=>acknowledge,:message=>message)
	end
end
