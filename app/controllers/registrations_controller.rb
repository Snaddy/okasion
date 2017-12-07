class RegistrationsController < Devise::RegistrationsController

  before_action :check_provider, only: [:update_password, :edit_password]
  before_action :authenticate_user!, only: [:update, :update_password, :edit_password, :update_city, :city]

	def update
    @user = current_user
    if @user.update(user_params)
      if @user.email_changed?
        @user.confirmed = false
      end
      @user.update_column(:email, user_params[:email])
      redirect_to profile_path
      flash[:notice] = 'Changes saved successfully'
    else
      super
    end
  end

  def update_password
    @user = current_user
      if @user.update_with_password(password_params)
        #bypass_sign_in(@user)
        redirect_to profile_path
        flash[:notice] = 'Successfully changed password. Please log in with your new password!'
      else
        render "edit_password"
      end
  end

  def edit_password
    @user = current_user
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


  def check_provider
    if current_user.provider?
      redirect_to profile_path
    end
  end

	private

	def city_params
    params.require(:user).permit(:city)
  end

  def user_params
    params.require(:user).permit(:email, :name, :city)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end

end