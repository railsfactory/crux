class UserPasswordsController < Devise::PasswordsController
  include SpreeBase
  helper :users, 'spree/base'

  def new
    super
  end

  def create
    user=User.find_by_email_and_domain_url(params[:user][:email],get_sub_domain(current_subdomain))
    if user
      self.resource = resource_class.send_reset_password_instructions(params[resource_name])
      if resource.errors.empty?
        set_flash_message(:notice, :send_instructions) if is_navigational_format?
        respond_with resource, :location => new_session_path(resource_name)
      else
        respond_with_navigational(resource){ render_with_scope :new }
      end
    else
      flash.now[:error]="You are not a registered user of this site"
      respond_with_navigational(resource){ render_with_scope :new }
    end
  end

  def edit
    super
  end

  def update
    super
  end

end
