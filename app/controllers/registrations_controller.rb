class RegistrationsController < Devise::RegistrationsController

	def update
    @user = current_user
        if @user.update(user_params)
          redirect_to profile_path 
        else
          super
        end
  end

  def update_city
		@user = current_user
        if @user.update(city_params)
          redirect_to root_path
        else
          render 'city'
        end
	end

	def city
		@user = current_user
	end

	protected

  	def update_resource(resource, params)
    	resource.update_without_password(params)
  	end

	private

	def city_params
      	params.require(:user).permit(:city)
  end

  def user_params
        params.require(:user).permit(:email, :name, :city)
  end

end