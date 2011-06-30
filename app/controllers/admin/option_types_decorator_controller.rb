Admin::OptionTypesController.class_eval do

 def set_available_option_types
      domain=find_user_domain
      @available_option_types = OptionType.find_all_by_domain_url(domain)
      selected_option_types = []
      @product.options.each do |option|
        selected_option_types << option.option_type
      end
      @available_option_types.delete_if {|ot| selected_option_types.include? ot}
end
end
