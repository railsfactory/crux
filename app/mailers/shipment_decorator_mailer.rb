class ShipmentMailer < ActionMailer::Base
  helper "spree/base"
  require "mail_domain_interceptor"
  include Spree::BaseHelper
def shipped_email(shipment, resend=false)
    @domain=find_mail_domain(shipment.order)
    mail_settings(@domain)
    @shipment = shipment
    subject = (resend ? "[RESEND] " : "")
    subject += "#{Spree::Config[:site_name]} #{t('subject', :scope => 'shipment_mailer.shipped_email')} ##{shipment.order.number}"
    mail(:to => shipment.order.email,
         :subject => subject)
       end
  end
