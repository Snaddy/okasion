class Api::V1::SessionsController < Devise::SessionsController

    skip_before_action :verify_signed_out_user, only: [:destroy]

    def create
      @user = User.find_by(email: params[:email])
      if @user.valid_password?(params[:password])
        sign_in(@user)
        if current_user.save
              render json: {
                status: "success",
                email: current_user.email,
                auth_token: current_user.authentication_token
              }
        else
          render json: { status: user.errors.full_messages }
        end
      end
    end

    def destroy
      @user = User.find(session[:user_id]).destroy
      @user.update_column(:authentication_token, nil)
      render json: { status: "success" }
    end
end