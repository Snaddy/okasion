class ConfirmationsController < Devise::ConfirmationsController

	before_action :authenticate_user!, only: [:send_confirmation]

	def send_confirmation
		@user = current_user
		@user.send_reconfirmation_instructions
		redirect_to root_path
		flash[:notice] = 'Confirmation email sent!'
	end

	protected

	def after_confirmation_path_for(resource, resourec_name)
		confirmed_path
  	end

end