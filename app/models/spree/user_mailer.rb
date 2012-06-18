module Spree
  class UserMailer < ActionMailer::Base
    include Spree::BaseHelper
    default:from=>"no-reply@example.com"
    def reset_password_instructions(user)
      domain=user.domain_url
      a=user.reset_password_token
      mail(:to => user.email,
        :subject => Spree::Config[:site_name] + '' + I18n.t(:password_reset_instructions),
        :body=>"http://#{domain}.crux.railsfactory.com/user/password/reset_password?token=#{a}" )
    end
  end
end

