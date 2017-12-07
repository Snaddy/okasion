class ConfirmationsController < Devise::ConfirmationsController

	before_action :authenticate_user!

	def send_confirmation
		render 'index'
		@user = current_user
		@user.send_reconfirmation_instructions
		flash[:notice] = 'Confirmation email sent!'
	end

	def after_confirmation_path_for(resource_name, resource)
    	sign_in(resource)
    	root_path
  	end

end