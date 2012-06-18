module Spree
  module Admin
    module BaseHelper
      def find_user_domain
        unless current_user.has_role?"admin"
          domain=current_user.domain_url
        else
          domain="admin"
        end
      end

      #To find the total transaction fee for the store owners
      def find_transaction_fee(owner)
        if owner && !owner.domain.blank?
          products=Spree::StoreDetail.where("domain_url=?",owner.domain).map(&:product_id).uniq
          if products && !products.empty?
            final_price=0
            products.each do |product|
              pro_quantity=Spree::StoreDetail.find_all_by_product_id(product).map(&:quantity).sum
              pro_id=Spree::Product.find_by_id(product)
              total_price=(pro_id.master.price*(owner.pricing_plan.transaction_fee/100))*pro_quantity
              final_price=final_price+total_price
            end
          end
          return final_price
        end
      end

      #To find the corressponding customized domain
      def find_customization_domain
        customdomain=(request.url).split("/")[2]
        custom=Spree::DomainCustomize.find_by_custom_domain(customdomain)
      end

      #To find the corressponding sub domain
      def get_sub_domain(domain)
        if (request.url.include?(APP_CONFIG['separate_url']))
          subdomain= domain.split(".")[0] if domain
        elsif find_customization_domain
          store=Spree::StoreOwner.find_by_id(find_customization_domain.store_owner_id)
          subdomain=store.domain
        end
        return subdomain
      end

      #To find  the number of products to restrict the store owner(Based on pricing plan)
      def products_count_checking(user)
        pricing_count=user.store_owner.pricing_plan.no_of_products
        products_count=Spree::Product.where(:domain_url=>user.domain_url,:deleted_at=>nil).length
        if pricing_count>products_count
          return true
        else
          return false
        end
      end

      #To find the preference for various settings

      def find_domain_preference(type)
        config=Spree::Configuration.find_by_name(type)
        if config
          available=Spree::Preference.find(:all,:conditions =>["domain_url=? AND owner_type=? AND owner_id=? ",get_sub_domain(current_subdomain),"Configuration",config.id])
        else
          available=[]
        end
      end







      def field_container(model, method, options = {}, &block)
        css_classes = options[:class].to_a
        if error_message_on(model, method).present?
          css_classes << 'withError'
        end
        content_tag('p', capture(&block), :class => css_classes.join(' '), :id => "#{model}_#{method}_field")
      end

      def error_message_on(object, method, options = {})
        object = convert_to_model(object)
        obj = object.respond_to?(:errors) ? object : instance_variable_get("@#{object}")

        if obj && obj.errors[method].present?
          errors = obj.errors[method].map { |err| h(err) }.join('<br />').html_safe
          content_tag(:span, errors, :class => 'formError')
        else
          ''
        end
      end

      def class_for_error(model, method)
        if error_message_on :product, :name
        end
      end

      #You can add additional_fields to the product and variant models. See section 4.2 here: http://spreecommerce.com/documentation/extensions.html
      #If you do choose to add additional_fields, you can utilize the :use parameter to set the input type for any such fields. For example, :use => 'check_box'
      #In the event that you add this functionality, the following method takes care of rendering the proper input type and logic for the supported input-types, which are text_field, check_box, radio_button, and select.
      def get_additional_field_value(controller, field)
        attribute = attribute_name_for(field[:name])

        value = eval("@" + controller.controller_name.singularize + "." + attribute)

        if value.nil? && controller.controller_name == "variants"
          value = @variant.product.has_attribute?(attribute) ? @variant.product[attribute] : nil
        end

        if value.nil?
          return value
        else
          return field.key?(:format) ? sprintf(field[:format], value) : value
        end
      end

      # This method demonstrates the use of the :child_index option to render a
      # form partial for, for instance, client side addition of new nested
      # records.
      #
      # This specific example creates a link which uses javascript to add a new
      # form partial to the DOM.
      #
      #   <%= form_for @project do |project_form| %>
      #     <div id="tasks">
      #       <%= project_form.fields_for :tasks do |task_form| %>
      #         <%= render :partial => 'task', :locals => { :f => task_form } %>
      #       <% end %>
      #     </div>
      #   <% end %>
      def generate_html(form_builder, method, options = {})
        options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
        options[:partial] ||= method.to_s.singularize
        options[:form_builder_local] ||= :f

        form_builder.fields_for(method, options[:object], :child_index => 'NEW_RECORD') do |f|
          render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
        end

      end

      def generate_template(form_builder, method, options = {})
        escape_javascript generate_html(form_builder, method, options)
      end

      def remove_nested(fields)
        out = ''
        out << fields.hidden_field(:_destroy) unless fields.object.new_record?
        out << (link_to icon('delete'), "#", :class => 'remove')
        out.html_safe
      end

      def preference_field_tag(name, value, options)
        case options[:type]
        when :integer
          text_field_tag(name, value, preference_field_options(options))
        when :boolean
          hidden_field_tag(name, 0) +
            check_box_tag(name, 1, value, preference_field_options(options))
        when :string
          text_field_tag(name, value, preference_field_options(options))
        when :password
          password_field_tag(name, value, preference_field_options(options))
        when :text
          text_area_tag(name, value, preference_field_options(options))
        else
          text_field_tag(name, value, preference_field_options(options))
        end
      end

      def preference_field_for(form, field, options)
        case options[:type]
        when :integer
          form.text_field(field, preference_field_options(options))
        when :boolean
          form.check_box(field, preference_field_options(options))
        when :string
          form.text_field(field, preference_field_options(options))
        when :password
          form.password_field(field, preference_field_options(options))
        when :text
          form.text_area(field, preference_field_options(options))
        else
          form.text_field(field, preference_field_options(options))
        end
      end

      def preference_field_options(options)
        field_options = case options[:type]
        when :integer
          { :size => 10,
            :class => 'input_integer' }
        when :boolean
          {}
        when :string
          { :size => 10,
            :class => 'input_string' }
        when :password
          { :size => 10,
            :class => 'password_string' }
        when :text
          { :rows => 15,
            :cols => 85 }
        else
          { :size => 10,
            :class => 'input_string' }
        end

        field_options.merge!({
            :readonly => options[:readonly],
            :disabled => options[:disabled]
          })
      end

      def preference_fields(object, form)
        return unless object.respond_to?(:preferences)
        object.preferences.keys.map{ |key|

          form.label("preferred_#{key}", t(key) + ": ") +
            preference_field_for(form, "preferred_#{key}", :type => object.preference_type(key))

        }.join("<br />").html_safe
      end

      def additional_field_for(controller, field)
        field[:use] ||= 'text_field'
        options = field[:options] || {}

        object_name, method = controller.controller_name.singularize, attribute_name_for(field[:name])

        case field[:use]
        when 'check_box'
          check_box(object_name, method, options, field[:checked_value] || 1, field[:unchecked_value] || 0)
        when 'radio_button'
          html = ''
          field[:value].call(controller, field).each do |value|
            html << radio_button(object_name, method, value, options)
            html << " #{value.to_s} "
          end
          html
        when 'select'
          select(object_name, method, field[:value].call(controller, field), options, field[:html_options] || {})
        else
          value = field[:value] ? field[:value].call(controller, field) : get_additional_field_value(controller, field)
          __send__(field[:use], object_name, method, options.merge(:value => value))
        end # case
      end

      def product_picker_field(name, value)
        products = Product.with_ids(value.split(','))
        product_names = products.inject({}){|memo,item| memo[item.id] = item.name; memo}
        product_rules = products.collect{ |p| { :id => p.id, :name => p.name } }
        %(<input type="text" name="#{name}" value="#{value}" class="tokeninput products" data-names='#{product_names.to_json}' data-pre='#{product_rules.to_json}'/>).html_safe
      end

      # renders set of hidden fields and button to add new record using nested_attributes
      def link_to_add_fields(name, append_to_selector, f, association)
        new_object = f.object.class.reflect_on_association(association).klass.new
        fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
          render(association.to_s.singularize + "_fields", :f => builder)
        end
        link_to_function(name, raw("add_fields(\"#{append_to_selector}\", \"#{association}\", \"#{escape_javascript(fields)}\")"), :class => 'add_fields')
      end

      # renders hidden field and link to remove record using nested_attributes
      def link_to_remove_fields(name, f)
        f.hidden_field(:_destroy) + link_to_with_icon(:delete, name, '#', :class => 'remove_fields')
      end

      def spree_dom_id(record)
        dom_id(record, 'spree')
      end
      def find_stock_value(attr)
        pref=find_domain_preference("Default configuration")
        if  pref.blank?
          if attr=="show_zero_stock_products"
            val=Spree::Config[:show_zero_stock_products]
          elsif attr=="allow_backorders"
            val=Spree::Config[:allow_backorders]
          end
        else
          val=pref.select{|x|x.name==attr}.map(&:value)[0]
        end
        return val
      end

      def get_taxons(domain)
        subdomain= get_sub_domain(domain)
        taxon=Spree::Taxon.roots.where('domain_url= ?',subdomain)
      end

      def find_storeowner_email(order)
        domain=find_mail_domain(order)
        store_owner=Spree::StoreOwner.find_by_domain(domain)
        store_owner=store_owner.user.email
      end


      def find_mail_domain(order)
        store=Spree::StoreownerOrder.find_by_order_id(order.id)
        mail_domain=store.store_owner.domain
      end

      def mail_settings(domain)
				mail_methods=Spree::MailMethod.find_all_by_domain_url(domain)
        unless mail_methods.blank?
          Spree::MailSettings.init(domain)
          Mail.register_interceptor(MailDomainInterceptor)
          return true
        else
          return false
        end
      end

      def get_sub_domain(domain)
        if (request.url.include?(APP_CONFIG['separate_url']))
          subdomain= domain.split(".")[0] if domain
        else
          store=Spree::StoreOwner.find_by_id(find_customization_domain.store_owner_id)
          subdomain=store.domain
        end
        return subdomain
      end

      def find_customization_domain
        customdomain=(request.url).split("/")[2]
        custom=Spree::DomainCustomize.find_by_custom_domain(customdomain)
      end

      def find_digital_domain(order)
        store=Spree::StoreownerOrder.find_by_order_id(order.id)
        if store.is_custom?
          return store.store_owner.domain_customize.custom_domain
        else
          return store.store_owner.domain+"."+APP_CONFIG['separate_url']+"."+APP_CONFIG['domain_url'].split(".").last
        end
      end

      def find_domain_preference(type)
        config=Spree::Configuration.find_by_name(type)
        if config
          available=Preference.find(:all,:conditions =>["domain_url=? AND owner_type=? AND owner_id=? ",get_sub_domain(current_subdomain),"Configuration",config.id])
        else
          available=[]
        end
      end
      def find_mail_methods(domain)
        @mail= Spree::MailMethod.where("environment=? AND domain_url=?",Rails.env,domain)
        return @mail
      end
      def find_latest_products
        Spree::Product.find(:all,:conditions=>["domain_url=? AND deleted_at IS NULL",get_sub_domain(current_subdomain)],:order=>"id desc",:limit=>10)
      end
      private
      def attribute_name_for(field_name)
        field_name.gsub(' ', '_').downcase
      end
    end
  end
end
