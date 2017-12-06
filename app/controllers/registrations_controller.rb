class RegistrationsController < Devise::RegistrationsController

  before_action :check_provider, only: [:update_password, :edit_password]
  before_action :authenticate_user!, only: [:update, :update_password, :edit_password, :update_city, :city]
  before_action :email_password_reset, only: [:reset_password]

	def update
    @user = current_user
    if @user.update(user_params)
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

  def reset_password
    @user = User.find_by(email: params[:email])
    if User.exists?(email: params[:email])
      @user.send_reset_password_instructions
      flash[:notice] = "Password reset was successfully sent"
    else
      flash[:warning] = "This email could not be found"
    end
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

  def email_password_reset
    if @user.provider?
      redirect_to root_path
      if @user.provider == 'facebook'
        flash[:warning] = 'This email is connected to facebook. Please try logging in with Facebook instead'
      else @user.provider == 'google_oauth2'
        flash[:warning] = 'This email is connected to Google. Please try logging in with Google instead'
      end
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