class ConfirmationsController < Devise::ConfirmationsController

	before_action :authenticate_user!

	def send_confirmation
		render 'root'
		@user = current_user
		@user.send_reconfirmation_instructions
		flash[:notice] = 'Confirmation email sent!'
	end

	private

	# def after_confirmation_path_for(resource_name, resource)
	# 	flash[:notice] = 'Thanks for confirming your email!'
	# 	flash.keep
	# 	root_path
	# end

end