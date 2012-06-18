Spree::MailMethod.class_eval do
  attr_accessible :domain_url
  def self.current(domain=nil,id=nil)
    if domain==nil
      return nil
    elsif domain=="domain" && id=="interceptor"
      return @mail
    else
      @mail= Spree::MailMethod.where("environment=? AND domain_url=?",Rails.env,domain).first
      return @mail
    end
  end
end