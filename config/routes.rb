Spree::Core::Engine.routes.append do
  # Add your extension routes here
	root :to => 'home#index'
	match '/admin/store_details'=>'admin/store_details#index'
	match '/admin/store_details/billing_history'=>'admin/store_details#billing_history'
	match '/admin/store_details/store_billing'=>'admin/store_details#store_billing'
	match '/admin/owners'=>'admin/users#index',:as =>:admin_store_owners
	match 'store/:id' => 'stores_registration#new_store'
	match 'store' => 'stores_registration#save_store_details'
	match '/storeowner' => 'stores_registration#storeowner',:as=>:storeowner
	match 'user_update_plan/:plan_id'=>'admin/upgrade_plans#user_update_plan',:as=>:update_plan
	match 'admin/store_registration_payment_method'=>'admin/payment_methods#store_registration_payment_method',:as=>:store_registration_payment_method
	match '/admin/users/store_status'=>'admin/users#store_owners'
	#~ match "/admin/pricing_plans" => "admin/pricing_plans#index",:as=>"pricing_plans"
	#~ match "/admin/pricing_plans" => "admin/pricing_plans#index",:as=>"admin_pricing_plans"
	#~ match "/admin/pricing_plans/show" => "admin/pricing_plans#show",:as=>"admin_pricing_plan"
	#~ match "/admin/pricing_plans/new" => "admin/pricing_plans#new",:as=>"new_admin_pricing_plan"
	#~ match "/admin/pricing_plans/edit" => "admin/pricing_plans#edit",:as=>"edit_admin_pricing_plan"
	#~ match "/admin/pricing_plans/create" => "admin/pricing_plans#create",:as=>"new_admin_pricing_plan"
	namespace :admin do
	resources :pricing_plans 
		  
		#~ end
		
		resources :domain_customizes
		resources :upgrade_plans
	end
	resources :stores_registration
end
