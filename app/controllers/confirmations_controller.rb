class ConfirmationsController < Devise::ConfirmationsController

	before_action :authenticate_user!

	def send_confirmation
		@user = current_user
		@user.send_reconfirmation_instructions
		flash[:notice] = 'Confirmation email sent!'
		redirect_to root_path
	end

	private

	def after_confirmation_path_for(resource_name, resource)
		flash[:notice] = 'Thanks for confirming your email!'
		redirect_to root_path
	end

end