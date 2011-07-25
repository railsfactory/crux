class UserMailer < ActionMailer::Base
  include Spree::BaseHelper

  def reset_password_instructions(user)
    default_url_options[:host] = user.domain_url+"."+APP_CONFIG['domain_url'].split("//")[1]
    available_mail=mail_settings(user.domain_url)
    @edit_password_reset_url = edit_user_password_url(:reset_password_token => user.reset_password_token)
    if available_mail
    mail(:to => user.email,
         :subject => Spree::Config[:site_name] + ' ' + I18n.t("password_reset_instructions"))
    else
      mail(:from => Spree::Config[:mails_from],:to => user.email,
         :subject => Spree::Config[:site_name] + ' ' + I18n.t("password_reset_instructions"))
  end
  end

end

