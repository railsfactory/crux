Admin::PaymentsController.class_eval do 
include Admin::BaseHelper
  def load_data
    @amount = params[:amount] || load_order.total
    @payment_methods = PaymentMethod.available(:back_end).reject{|x| x.domain_url!=current_user.domain_url}
    if @payment and @payment.payment_method
      @payment_method = @payment.payment_method
    else
      @payment_method = @payment_methods.first
    end
    @previous_cards = @order.creditcards.with_payment_profile
  end
end
