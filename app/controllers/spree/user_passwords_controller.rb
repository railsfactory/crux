class Spree::UserPasswordsController < Devise::PasswordsController
  include Spree::BaseHelper
  helper 'spree/users', 'spree/base'
  layout "spree/layouts/home"

  def new
    super
  end

  def create
   p  user=Spree::User.find_by_email_and_domain_url(params[:user][:email],get_sub_domain(current_subdomain))
    if user
      p params[resource_name]
      self.resource = resource_class.send_reset_password_instructions(params[resource_name])
      p "!1111111111111111111111111111111111111!!"
      if resource.errors.empty?
        set_flash_message(:notice, :send_instructions) if is_navigational_format?
      respond_with resource, :location => spree.login_path
      else
        respond_with_navigational(resource){ render :new }
      end
    else
      flash.now[:error]="You are not a registered user of this site"
      respond_with_navigational(resource){ render :new }
    end
  end

  def edit
    super
  end

  def update
    super
  end
def reset_password
  p params
  user=Spree::User.find_by_	reset_password_token()
  end
end
