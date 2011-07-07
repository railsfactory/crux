class UserSessionsController < Devise::SessionsController
  include SpreeBase
  helper :users, 'spree/base'
  before_filter :load_account
  include Spree::CurrentOrder
  after_filter :associate_user, :only => :create
  ssl_required :new, :create, :destroy, :update
  ssl_allowed :login_bar

  # GET /resource/sign_in
  def new
    super
  end

  def create
  authenticate_user!
  if user_signed_in?
  logged_in_user = current_user
  if (request.url.include?(APP_CONFIG['domain_url']) || request.url.include?(APP_CONFIG['secure_domain_url']))
      (logged_in_user.domain_url.blank?)? (show_success_message):(show_error)
    else
      subdomain=current_subdomain.split(".")

      store=StoreOwner.find_by_user_id(logged_in_user)
      customize_domain=DomainCustomize.find_by_store_owner_id(store)
      if logged_in_user.domain_url == subdomain[0]
        (logged_in_user.is_owner?)? (redirect_to storeowner_url(:subdomain =>logged_in_user.domain_url + ".#{APP_CONFIG['separate_url']}",:user_id=>logged_in_user.id)) :(show_success_message)
      elsif logged_in_user.store_owner && logged_in_user.store_owner.domain_customize.custom_domain ==find_customization_domain.custom_domain
              (logged_in_user.is_owner?)? (redirect_to storeowner_url(:user_id=>logged_in_user.id)) :(show_success_message)
              else
          show_error
      end
    end
  else
  flash[:error] = I18n.t("devise.failure.invalid")
  render :new
end
end
def show_error
  session.clear
  flash[:error]="You are not a registered user of this site"
  redirect_to  new_user_session_path
end
def show_success_message
  flash.notice = I18n.t("logged_in_succesfully")
  if current_user.has_role?"admin"
    redirect_to '/admin'
  else
  redirect_to products_path
end
end

  def destroy
    session.clear
    super
  end

  def nav_bar
    render :partial => "shared/nav_bar"
  end

  private

  def associate_user
    return unless current_user and current_order
    current_order.associate_user!(current_user)
    session[:guest_token] = nil
  end

  def accurate_title
    I18n.t(:log_in)
  end

 end
