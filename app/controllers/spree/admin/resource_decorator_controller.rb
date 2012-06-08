require 'spree/core/action_callbacks'
Spree::Admin::ResourceController.class_eval do
                include Spree::Admin::BaseHelper
                def create
                        p "1111111111111111111111111111111111===================================="
                        invoke_callbacks(:create, :before)
                        name =  @object.class.name
                        success=@object.valid?
                        if unique_sku_value && success
                                @object.save
                          name =  @object.class.name
                                if @object.save
                                        add_domain
                                                invoke_callbacks(:create, :after)
                                                flash[:notice] = flash_message_for(@object, :successfully_created)
                                        respond_with(@object) do |format|
                                                format.html { redirect_to location_after_save }
                                                format.js   { render :layout => false }
                                        end
                                else
                                        render_file
                                end
                        else
                                render_file
                        end        
                end

                def add_domain
                        p "1111111111888888888888888888888888888888888888888888888"
                        if condition
                                p "________________________________________________________"
                                p @object.update_attributes(:domain_url=>find_user_domain)
                                if (model_class.name == "Taxonomy")
                                        @object.root.update_attributes(:domain_url=>find_user_domain)
                                end
                  elsif (model_class.name == "User")
                                @object.update_attributes(:domain_url=>find_user_domain)
                        end
                end

                def  render_file
                        invoke_callbacks(:create, :fails)
                        respond_with(@object)
                end

                def unique_sku_value
                        if @object.class.name=="Product"
                                product_sku=Spree::Product.find_all_by_domain_url(current_user.domain_url).map(&:sku)
                                if product_sku.include?(params[:product][:sku])
                                        @object.errors[:sku]<<"must be Unique"
                                                return false
                                end
                        end
                        return true
                end

		protected
		def collection
			return parent.send(controller_name) if parent_data.present?
			if condition
				model_class.accessible_by(current_ability).where("domain_url in (?)",find_user_domain)
			  elsif model_class.respond_to?(:accessible_by) && !current_ability.has_block?(params[:action], model_class)
					model_class.accessible_by(current_ability)
			else
			  	model_class.scoped
			end
		end

		def condition
			p "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
			p model_class.name
			if ((model_class.name == "Spree::Product")||(model_class.name == "Spree::User")||(model_class.name == "Spree::OptionType")||(model_class.name == "Spree::Property")||(model_class.name == "Spree::Prototype")||(model_class.name == "Spree::ProductGroup")||(model_class.name == "Spree::MailMethod")||(model_class.name == "Spree::TaxCategory")||(model_class.name == "Spree::Zone")||(model_class.name == "Spree::PaymentMethod")||(model_class.name == "Spree::ShippingMethod")||(model_class.name == "Spree::ShippingCategory")||(model_class.name == "Spree::Taxonomy") ||(model_class.name == "Spree::Activator"))
		    return true
			else
			  return false
			end
		end
end
