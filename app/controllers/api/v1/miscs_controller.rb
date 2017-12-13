class Api::V1::MiscsController < ActionController::Base

	def email_search
		@result = User.email_exists?(params[:email_search])
		render json: {
			status: @result
		}
	end

	def password_reset
		@user = User.find_by(email: params[:email])
		if User.exists?(email: params[:email])
			@user.send_reset_password_instructions
			render json: {message: 'success'}
		end
	end

end