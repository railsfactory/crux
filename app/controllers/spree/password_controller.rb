class Spree::PasswordController < Spree::BaseController
	def reset_password
  @user=Spree::User.find_by_reset_password_token(params[:token])
end
def reset_password_data
	p @user=Spree::User.find_by_reset_password_token(params[:token])
	if @user.present?
	if params[:password]==params[:password_confirmation]
	@user.update_attributes(:password=>params[:password])
	flash[:notice]="password has been changed successfully"
	redirect_to "/login"
	else
		flash[:notice]="password not matching"
	end
	else
		flash[:notice]="user is not registered "
		redirect_to "/login"
	end
	end
	end