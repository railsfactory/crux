module Spree
  module Core
    class MailInterceptor

    def self.delivering_email(message)
      p mail_method = Spree::MailMethod.current("domain","interceptor")
      return unless mail_method = Spree::MailMethod.current("domain","interceptor")
      message.from ||= mail_method.preferred_mails_from
      if mail_method.preferred_intercept_email.present?
        message.subject = "[#{message.to}] #{message.subject}"
        message.to = mail_method.preferred_intercept_email
      end
      p "111111111111111111111111111111111!"
      if mail_method.preferred_mail_bcc.present?
        message.bcc = mail_method.preferred_mail_bcc
      end
    end
end
end
end