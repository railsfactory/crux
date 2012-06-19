class Spree::UserSessionsController < Devise::SessionsController
  #~ include  Spree::Core::Search::Base
  include Spree::Core::ControllerHelpers
  include Spree::Core::RespondWith
  before_filter :load_account
  include Spree::Core::CurrentOrder
  after_filter :associate_user, :only => :create
  ssl_required :new, :create, :destroy, :update
  ssl_allowed :login_bar
  layout "spree/layouts/home"
  # GET /resource/sign_in
  def new
    super
  end

  def create
    unless (request.url.include?(APP_CONFIG['domain_url']) || request.url.include?(APP_CONFIG['secure_domain_url']))
      $domain_value_url=get_sub_domain(current_subdomain)
    else
      $domain_value_url=""
    end
    authenticate_user!
    if user_signed_in?
      logged_in_user = current_user
      if (request.url.include?(APP_CONFIG['domain_url']) || request.url.include?(APP_CONFIG['secure_domain_url']))
        (logged_in_user.domain_url.blank?)? (show_success_message):(show_error)
      else
        subdomain=current_subdomain.split(".")
        store=Spree::StoreOwner.find_by_user_id(logged_in_user)
        customize_domain=Spree::DomainCustomize.find_by_store_owner_id(store)
        if logged_in_user.domain_url == subdomain[0]
          (logged_in_user.is_owner?)? (redirect_back_or_default(products_path)) :(show_success_message)
        elsif logged_in_user.store_owner && find_customization_domain && logged_in_user.store_owner.domain_customize.custom_domain == find_customization_domain.custom_domain
          (logged_in_user.is_owner?)? (redirect_back_or_default(products_path)) :(show_success_message)
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
      redirect_back_or_default(products_path)
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
