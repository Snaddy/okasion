class Api::V1::MiscsController < ActionController::Base

	def email_search
		if User.exists?(email: params[:email])
			render json: {
				status: "true"
			}
		else
			render json: {
				status: "false"
			}
		end
	end

	def reset_password
		@user = User.find_by(email: params[:email])
		if User.exists?(email: params[:email])
			@user.send_reset_password_instructions
			render json: {status: 'success'}
		else 
			render json: {status: 'error'}
		end
	end

end