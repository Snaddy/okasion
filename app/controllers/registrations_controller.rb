class RegistrationsController < Devise::RegistrationsController

	def update_city
		@user = current_user
        if @user.update(update_params)
          redirect_to root_path
          flash[:notice] = "City saved."
        else
          render 'city'
        end
	end

	def city
		@user = current_user
	end

	protected

	private

	def update_params
      params.require(:user).permit(:city)
    end
end