class HomeController < Spree::BaseController
   require 'will_paginate/array'
   helper :products
   respond_to :html
   include Admin::BaseHelper
   layout :choose_layout
   def index
     @searcher = Spree::Config.searcher_class.new(params)
     domain = get_sub_domain(current_subdomain)
     @products = @searcher.retrieve_products(domain)
      respond_with(@products)
   end

   def choose_layout
      if (request.url.include?(APP_CONFIG['domain_url']) || request.url.include?(APP_CONFIG['secure_domain_url']))
         return "saas"
      else
         return "spree_application"
      end
   end

end