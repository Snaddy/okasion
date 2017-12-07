class ConfirmationsController < Devise::ConfirmationsController

	before_action :authenticate_user!

	def send_confirmation
		@user = current_user
		@user.send_confirmation_instructions
		flash[:notice] = 'Confirmation email sent!'
		redirect_to root_path
	end

	private

	def after_confirmation_path_for(resource_name, resource)
		redirect_to root_path
		flash[:notice] = 'Thanks for confirming your email!'
	end

end