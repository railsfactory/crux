class UsersController < Spree::BaseController
    prepend_before_filter :load_object, :only => [:show, :edit, :update]
    prepend_before_filter :authorize_actions, :only => :new
    def show
      @orders = @user.orders.complete
      @store_owner=@user.store_owner
    end

    def create
      @user = User.new(params[:user])
      if @user.save 
        if current_order
          current_order.associate_user!(@user)
          session[:guest_token] = nil
        end
        redirect_back_or_default(root_url)
      else
        render 'new'
      end
    end

    def update
      @store_owner=@user.store_owner
      if  @user.update_attributes(params[:user])
        @store_owner.update_attribute(:card_number,params[:store_owner][:card_number]) unless params[:store_owner][:card_number].blank?
        @store_owner.update_attribute(:cvv,params[:store_owner][:cvv]) unless params[:store_owner][:cvv].blank?
        if params[:user][:password].present?
          # this logic needed b/c devise wants to log us out after password changes
          user = User.reset_password_by_token(params[:user])
          sign_in(@user, :event => :authentication, :bypass => !Spree::Auth::Config[:signout_after_password_change])
        end
        flash.notice = I18n.t("account_updated")
        redirect_to account_url
      else
        render 'edit'
      end
    end

    private
    def load_object
      @user ||= current_user
      authorize! params[:action].to_sym, @user
      @store_owner=@user.store_owner
    end

    def authorize_actions
      authorize! params[:action].to_sym, User
    end

    def accurate_title
      I18n.t(:account)
    end

end
