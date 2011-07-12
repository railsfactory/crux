Rails.application.routes.draw do
  # Add your extension routes here
	match '/admin/store_details'=>'admin/store_details#index'
 match '/admin/store_details/billing_history'=>'admin/store_details#billing_history'
	match 'user_update_plan/:plan_id'=>'admin/upgrade_plans#user_update_plan',:as=>:update_plan

  namespace :admin do
    resources :pricing_plans
			#~ match '/admin/store_details/billing_history/:store'=>'admin/store_details#billing_history'

		#~ resources :store_details
		resources :domain_customizes
		resources :upgrade_plans
	end
	resources :stores_registration
  match 'store/:id' => 'stores_registration#new_store'
  match 'store' => 'stores_registration#save_store_details'
  match '/storeowner' => 'stores_registration#storeowner',:as=>:storeowner
	match '/admin/users/store_owners'=>'admin/users#store_owners',:as =>:store_owners
end
