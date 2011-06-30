class StoreRegisterMailer < ActionMailer::Base
	
def register_email(mailmethod,email)
	mail_initialize(mailmethod.domain_url)
	subject = "Store Registration"
	mail(:to => email,
	:subject => subject)
end

def mail_initialize(domain)
	Spree::MailSettings.init(domain)
	Mail.register_interceptor(MailDomainInterceptor)
end

end