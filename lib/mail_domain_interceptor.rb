class MailDomainInterceptor

    def self.delivering_email(message)
      return unless mail_method = MailMethod.current("domain","interceptor")
      message.from ||= mail_method.preferred_mails_from
      if mail_method.preferred_intercept_email.present?
        message.subject = "[#{message.to}] #{message.subject}"
        message.to = mail_method.preferred_intercept_email
      end
      if mail_method.preferred_mail_bcc.present?
        message.bcc = mail_method.preferred_mail_bcc
      end
    end
end