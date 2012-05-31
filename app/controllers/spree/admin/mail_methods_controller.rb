class Spree::Admin::MailMethodsController < Spree::Admin::ResourceController
  after_filter :initialize_mail_settings
  private
  def initialize_mail_settings
    Spree::Core::MailSettings.init
  end
end
