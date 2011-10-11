Admin::PaymentMethodsController.class_eval do
  include Admin::BaseHelper
  def create
    @payment_method = params[:payment_method][:type].constantize.new(params[:payment_method])
    @object = @payment_method
    invoke_callbacks(:create, :before)
    if @payment_method.save
		  	 @payment_method.update_attributes(:domain_url=>find_user_domain)
			   invoke_callbacks(:create, :after)
      flash[:notice] = I18n.t(:successfully_created, :resource => I18n.t(:payment_method))
      respond_with(@payment_method, :location => edit_admin_payment_method_path(@payment_method))
    else
      invoke_callbacks(:create, :fails)
      respond_with(@payment_method)
    end
  end
	
	def store_registration_payment_method
		if StoreRegPaymentMethod && StoreRegPaymentMethod.first
			@payment=StoreRegPaymentMethod.first
		else
			@payment=StoreRegPaymentMethod.new()
		end
		value=params[:store_reg_payment_method]
		if value && !value.blank?
			@payment.update_attributes(value)
			if @payment.save
				flash.now[:notice]="Payment Method has been updated successfully"
		  else
				render "store_registration_payment_method"
			end
		end
	end
end
