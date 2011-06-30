class StoresRegistrationController < Spree::BaseController
include SpreeBase
before_filter :load_account
ActiveMerchant::Billing::Base.mode = :test
include ActiveMerchant::Billing

def paypal_gateway	
	  gateway = ActiveMerchant::Billing::PaypalGateway.new(:login =>'railsf_1286521108_biz_api1.gmail.com',:password =>'1286521234',:signature =>'AU562tW4ph9J8h9tWUS9wpuYK9zeAKH7Mk4Fco.pSrh.tWlRw3XLBpiN')
	
		return gateway
		end
def index

@plans = PricingPlan.find(:all,:conditions=>"is_active=true")	

end

def new_store
	@user = User.new()
	@store_owner = StoreOwner.new()
	@plan = session[:plan] = params[:plan_name]
 	@amt=PricingPlan.find_by_plan_name(session[:plan]).amount
   #~ render:layout=>false
end

def save_store_details
	@amount= PricingPlan.find_by_plan_name(session[:plan]).amount
	@user = User.new(params[:user])
	@store_owner = @user.build_store_owner(params[:store_owner])
	@store_owner.plan_name = session[:plan]
	if @user.valid? && @store_owner.valid?
		response_payment=payment_response
	
			if  response_payment && response_payment.params['ack']=="Success"
					 @user.is_owner = true
						@user.domain_url = params[:store_owner][:domain]
						@user.roles << Role.find_by_name('storeowner')
						@user.save
						 mail_method=MailMethod.find_all_by_domain_url('admin').first
						unless mail_method.blank?
						StoreRegisterMailer.register_email(mail_method,@user.email).deliver
						end
						@store_owner.transaction_id=	response_payment.params['transaction_id']
						@store_owner.ip=request.remote_ip
						@store_owner.save
billing_history(response_payment.params['transaction_id'],@amount,@store_owner.id)
flash[:store_notice] = "Your Store has been registered successfully"
						current_user = @user
						redirect_to storeowner_url(:subdomain=>"#{@user.domain_url}.#{APP_CONFIG['separate_url']}",:user_id=>@user.id)
						#~ redirect_to "/admin"
				else
 	  			flash[:error]= response_payment.params['message']
	    		render  "new_store",:plan_name=>session[:plan]
   		end
	else
		render  "new_store",:plan_name=>session[:plan]
	end
end

def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.is_owner?
				flash.notice = I18n.t("logged_in_succesfully")
			admin_url(:subdomain =>resource.store_owner.domain + ".#{APP_CONFIG['separate_url']}")
			 #~ redirect_to '/admin'
    else
      super
    end
end
def storeowner
	@user = User.find_by_id(params[:user_id])
	sign_in_and_redirect(:user,@user)
end

	def credit_card
			

		ActiveMerchant::Billing::CreditCard.new(
:type =>  params[:store_owner][:card_type],
:first_name => params[:store_owner][:first_name],
:last_name => params[:store_owner][:last_name],
:number =>  params[:store_owner][:card_number],
:month =>  params[:store_owner][:expiration_month],
:year =>  params[:store_owner][:expiration_year],
:verification_value => params[:store_owner][:cvv]
)
 end

 def billing_address
	 address=Hash.new
address={ :name => params[:store_owner][:name],
:address1 => params[:store_owner][:street],
:address2 => '',
:city =>params[:store_owner][:city],
:state => params[:store_owner][:state],
:country => params[:store_owner][:country],
:zip => params[:store_owner][:zipcode],
:phone => params[:store_owner][:phoneno]}
end



def payment_response
	
authorize= paypal_gateway.authorize(@amount, credit_card,
:ip => request.remote_ip,
:billing_address =>billing_address
)

if authorize.params['ack']=="Success"
@response=paypal_gateway.capture(@amount, authorize.authorization)
@response
else
 	  			flash[:error]= authorize.params['message']
	    		render  "new_store",:plan_name=>session[:plan]
   		
end


end

def billing_history(transaction_id,total_amounts,owner)
	BillingHistory.create!(:store_owner_id=>owner,:amount=>total_amounts,:billing_date=>Date.today,:transaction_id=>transaction_id,:acknowledge=>"success",:payment_type=>"capture")
	end
end
