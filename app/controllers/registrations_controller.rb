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

	def after_inactive_sign_up_path_for(resource)
	    add_city_path
	end

	def after_sign_up_path_for(resource)
	    add_city_path
	end

	private

	def update_params
      params.require(:user).permit(:city)
    end
end