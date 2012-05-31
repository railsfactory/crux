module Spree
  module Core
    module ControllerHelpers
      def self.included(receiver)
        receiver.send :layout, :get_layout
        receiver.send :before_filter, 'instantiate_controller_and_action_names'
        receiver.send :before_filter, 'set_user_language'

        receiver.send :helper_method, 'title'
        receiver.send :helper_method, 'title='
        receiver.send :helper_method, 'accurate_title'
        receiver.send :helper_method, 'get_taxonomies'
        receiver.send :helper_method, 'current_order'
        receiver.send :include, SslRequirement
        receiver.send :include, Spree::Core::CurrentOrder
      end

      def access_forbidden
        render :text => 'Access Forbidden', :layout => true, :status => 401
      end

      # can be used in views as well as controllers.
      # e.g. <% title = 'This is a custom title for this view' %>
      attr_writer :title

      def title
        title_string = @title.present? ? @title : accurate_title
        if title_string.present?
          if Spree::Config[:always_put_site_name_in_title]
            [default_title, title_string].join(' - ')
          else
            title_string
          end
        else
          default_title
        end
      end
    def load_account
      unless (request.url.include?(APP_CONFIG['domain_url']) || request.url.include?(APP_CONFIG['secure_domain_url'])) 
        domain = get_sub_domain(current_subdomain)
        @store = StoreOwner.find_by_domain(domain)
        if request.url.include?(APP_CONFIG['separate_url'])
          unless @store.blank?
           active = @store.is_active? 
            if !active 
             redirect_to "#{APP_CONFIG['domain_url']}"     
            end
        else
         redirect_to "#{APP_CONFIG['domain_url']}"
        end
      else        
        verify_custom_domain
      end
      end
    end

    def verify_custom_domain
      custom_domain_status=find_customization_domain.status if find_customization_domain
      active = @store.is_active? if @store
      if find_customization_domain 
        if custom_domain_status  
          if !active                                        
           redirect_to "#{APP_CONFIG['domain_url']}"
          end
        else
         redirect_to "#{APP_CONFIG['domain_url']}"
        end
      end
    end



 def get_sub_domain(domain)
    if (request.url.include?(APP_CONFIG['separate_url']))
     subdomain= domain.split(".")[0] if domain
     else
       store=StoreOwner.find_by_id(find_customization_domain.store_owner_id) unless find_customization_domain.blank?
       subdomain=store.domain
       #~ custom_domain= domain.split(".") if domain
       #~ store=StoreOwner.find_by_custom_domain(domain)
       #~ subdomain=store.domain
     end
       return subdomain
   end
		
    def find_customization_domain
	customdomain=(request.url).split("/")[2]
	custom=DomainCustomize.find_by_custom_domain(customdomain)
	
end

    protected

        def default_title
          Spree::Config[:site_name]
        end

        # this is a hook for subclasses to provide title
        def accurate_title
          Spree::Config[:default_seo_title]
        end

        def render_404(exception = nil)
          respond_to do |type|
            type.html { render :status => :not_found, :file    => "#{::Rails.root}/public/404", :formats => [:html], :layout => nil}
            type.all  { render :status => :not_found, :nothing => true }
          end
        end

        # Convenience method for firing instrumentation events with the default payload hash
        def fire_event(name, extra_payload = {})
          ActiveSupport::Notifications.instrument(name, default_notification_payload.merge(extra_payload))
        end

        # Creates the hash that is sent as the payload for all notifications. Specific notifications will
        # add additional keys as appropriate. Override this method if you need additional data when
        # responding to a notification
        def default_notification_payload
          {:user => (respond_to?(:current_user) && current_user), :order => current_order}
        end

      private

        def redirect_back_or_default(default)
          redirect_to(session["user_return_to"] || default)
          session["user_return_to"] = nil
        end

        def instantiate_controller_and_action_names
          @current_action = action_name
          @current_controller = controller_name
        end

    def get_taxonomies(domain)
      current_store = get_sub_domain(domain)
    @taxonomies ||= Taxonomy.where('domain_url= ?',current_store).includes(:root => :children)
      @taxonomies.reject { |t| t.root.nil? }
    end

        def associate_user
          return unless current_user and current_order
          current_order.associate_user!(current_user)
          session[:guest_token] = nil
        end

        def set_user_language
          locale = session[:locale]
          locale ||= Spree::Config[:default_locale] unless Spree::Config[:default_locale].blank?
          locale ||= Rails.application.config.i18n.default_locale
          locale ||= I18n.default_locale unless I18n.available_locales.include?(locale.to_sym)
          I18n.locale = locale.to_sym
        end

        # Returns which layout to render.
        # 
        # You can set the layout you want to render inside your Spree configuration with the +:layout+ option.
        # 
        # Default layout is: +app/views/spree/layouts/spree_application+
        # 
        def get_layout
          layout ||= Spree::Config[:layout]
        end
    end
  end
end
