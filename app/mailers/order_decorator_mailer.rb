class OrderMailer < ActionMailer::Base
  helper "spree/base"
  include Spree::BaseHelper
  require "mail_domain_interceptor"
  def confirm_email(order,resend=false)
    @order = order
    @domain=find_mail_domain(order)
    unless @domain.blank?
    subject = (resend ? "[RESEND] " : "")
    available_mail=mail_settings(@domain)
    subject += "#{Spree::Config[:site_name]} #{t('subject', :scope =>'order_mailer.confirm_email')} ##{order.number}"
    if available_mail
    mail(:to => order.email,:subject => subject)
    else
    mail(:from =>find_storeowner_email(order) ,:to => order.email,:subject => subject)
   end
   end
  end

  def cancel_email(order, resend=false)
@order = order
@domain=find_mail_domain(order)
  unless @domain.blank?
  mail_settings(@domain)
  subject = (resend ? "[RESEND] " : "")
  subject += "#{Spree::Config[:site_name]} #{t('subject', :scope => 'order_mailer.cancel_email')} ##{order.number}"
    if available_mail
    mail(:to => order.email,:subject => subject)
    else
    mail(:from =>find_storeowner_email(order),:to => order.email,:subject => subject)

    end
  end
end
end
