class ConfirmationsController < Devise::ConfirmationsController

	before_action :authenticate_user!

	def send_confirmation
		render 'root'
		@user = current_user
		@user.send_reconfirmation_instructions
		flash[:notice] = 'Confirmation email sent!'
	end

end