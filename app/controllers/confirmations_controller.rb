class ConfirmationsController < Devise::ConfirmationsController

	before_action :authenticate_user!

	def send_confirmation
		@user = current_user
		@user.send_reconfirmation_instructions
		redirect_to root_path
		flash[:notice] = 'Confirmation email sent!'
	end

	def after_confirmation_path_for(resource_name, resource)
		if current_user
			root_path
			flash[:notice] = 'Thanks for verifying your email'
		else
			confirmed_path
		end
  	end

end