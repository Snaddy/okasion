class Api::V1::MiscsController < ActionController::Base

	def email_search
		@result = User.email_exists?(params[:email_search])
		render json: {
			status: @result
		}
	end

end