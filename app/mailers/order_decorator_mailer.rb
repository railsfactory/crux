class OrderMailer < ActionMailer::Base
  helper "spree/base"
  include Spree::BaseHelper
  require "mail_domain_interceptor"
  def confirm_email(order,resend=false)
    @order = order
    @domain=find_mail_domain(order)
    mail_settings(@domain)
    subject = (resend ? "[RESEND] " : "")
    subject += "#{Spree::Config[:site_name]} #{t('subject', :scope =>'order_mailer.confirm_email')} ##{order.number}"
    mail(:to => order.email,
         :subject => subject)
  end

  def cancel_email(order, resend=false)
@order = order
@domain=find_mail_domain(order)
    mail_settings(@domain)
    subject = (resend ? "[RESEND] " : "")
    subject += "#{Spree::Config[:site_name]} #{t('subject', :scope => 'order_mailer.cancel_email')} ##{order.number}"
    mail(:to => order.email,
         :subject => subject)
     end
     
end
