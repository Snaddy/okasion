class Api::V1::RegistrationsController < Devise::RegistrationsController

    def create
      @user = User.create(user_params)
      if @user.save
        sign_in(@user)
        render json: { status: "success",
          auth_token: current_user.authentication_token,
          email: current_user.email,
        }
      else
        render json: { status: user.errors.full_messages }
      end
    end

    # def update
    #   @user = current_user
    #     if @user.update(user_params)
    #       render json: { result: "success"}
    #     else
    #       render json: { result: "error"}
    #     end
    # end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

end