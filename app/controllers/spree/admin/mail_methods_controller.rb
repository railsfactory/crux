class Spree::Admin::MailMethodsController < Spree::Admin::ResourceController
  after_filter :initialize_mail_settings
   def testmail
        @mail_method = Spree::MailMethod.find(params[:id])
        if TestMailer.test_email(@mail_method, respond_to?(:current_user) ? current_user : nil).deliver
          flash.notice = t('admin.mail_methods.testmail.delivery_success')
        else
          flash[:error] = t('admin.mail_methods.testmail.delivery_error')
        end
      rescue Exception => e
        flash[:error] = t('admin.mail_methods.testmail.error') % {:e => e}
      ensure
        respond_with(@mail_method) { |format| format.html { redirect_to :back } }
      ends
  private
  def initialize_mail_settings
    Spree::Core::MailSettings.init
  end
end
