class Admin::UpgradePlansController < Admin::ResourceController
		resource_controller
		def index
			plan=current_user.store_owner.pricing_plan_id
			@pricing_plans=Spree::PricingPlan.find(:all,:conditions=>['is_active=? and id !=?',true,plan])
		end

		def user_update_plan
			user=	current_user.store_owner
			user.update_attribute(:pricing_plan_id,params[:plan_id])
			flash[:notice]="Your plan has been upgraded successfully"
			upgrade=UpgradePlan.create(:store_owner_id=>user.id,:plan_id=>user.pricing_plan_id)
			upgrade.save		
			redirect_to admin_upgrade_plans_path
		end		

end
