Rails.application.routes.draw do
  # Add your extension routes here
	
  namespace :admin do
    resources :pricing_plans
		resources :store_details
		resources :domain_customizes
	end
	resources :stores_registration
  match 'store/:plan_name' => 'stores_registration#new_store'
  match 'store' => 'stores_registration#save_store_details'
  match '/storeowner' => 'stores_registration#storeowner',:as=>:storeowner
	match '/admin/users/store_owners'=>'admin/users#store_owners',:as =>:store_owners
end
