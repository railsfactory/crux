module Spree
  module Core
    module Search
  class Base
    attr_accessor :properties

    def initialize(params)
      @properties = {}
      prepare(params)
    end

def retrieve_products(domain=nil)
			@products_scope = get_base_scope(domain)
          curr_page = page || 1

          @products = @products_scope.includes([:master]).page(curr_page).per(per_page)
				end
			
		
    def method_missing(name)
      @properties[name]
    end

    protected
    def get_base_scope(domain=nil)
      base_scope = Spree::Product.active
      base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
      base_scope = get_products_conditions_for(base_scope, keywords) unless keywords.blank?			
	    stock_val=check_stock_value("show_zero_stock_products",domain)
			base_scope = base_scope.on_hand unless stock_val
      base_scope = add_search_scopes(base_scope)
      base_scope
    end
		
		    def add_search_scopes(base_scope)
            search.each do |name, scope_attribute|
              next if name.to_s =~ /eval|send|system/

              scope_name = name.intern
              if base_scope.respond_to? scope_name
                base_scope = base_scope.send(scope_name, *scope_attribute)
              else
                base_scope = base_scope.merge(Spree::Product.search({scope_name => scope_attribute}).result)
              end
            end if search
            base_scope
          end
		
   def check_stock_value(attr,domain)
	config=Configuration.find_by_name("Default configuration")
	if config?
  pref=Preference.where("domain_url=? AND owner_type=? AND owner_id=? ",domain,"Configuration",config.id)	
	else
		pref=[]
	end
	if  pref.blank?
		val=Spree::Config[:show_zero_stock_products]
	else
				val=pref.select{|x|x.name==attr}.map(&:value)[0]
end
  return val
end


    # method should return new scope based on base_scope
    def get_products_conditions_for(base_scope, query)
      base_scope.like_any([:name, :description], query.split)
    end

    def prepare(params)
      @properties[:taxon] = params[:taxon].blank? ? nil : Taxon.find(params[:taxon])
      @properties[:keywords] = params[:keywords]

      per_page = params[:per_page].to_i
      @properties[:per_page] = per_page > 0 ? per_page : Spree::Config[:products_per_page]
      @properties[:page] = (params[:page].to_i <= 0) ? 1 : params[:page].to_i

      #~ if !params[:order_by_price].blank?
        #~ @product_group = ProductGroup.new.from_route([params[:order_by_price]+"_by_master_price"])
      #~ elsif params[:product_group_name]
        #~ @cached_product_group = ProductGroup.find_by_permalink(params[:product_group_name])
        #~ @product_group = ProductGroup.new
      #~ elsif params[:product_group_query]
        #~ @product_group = ProductGroup.new.from_route(params[:product_group_query].split("/"))
      #~ else
        #~ @product_group = ProductGroup.new
      #~ end
      #~ @product_group = @product_group.from_search(params[:search]) if params[:search]

    end
  end
end
end
end
