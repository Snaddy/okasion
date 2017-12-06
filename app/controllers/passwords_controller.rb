class PasswordsController < ApplicationController

def new
end

def reset_password
    if User.exists?(email: params[:new][:email])
    	@user = User.find_by(email: params[:new][:email])
    	if @user.provider?
    		if @user.provider = 'facebook'
    			flash[:notice] = 'This email is connected to Facebook. Please try logging in with Facebook instead'
    		else
    			flash[:notice] = 'This email is connected to Google. Please try logging in with Google instead'
    		end
    	    render 'new'
    	else
    		redirect_to login_path
    		flash[:notice] = 'You will be receiving an email with instructions to reset your password soon'
    		@user.send_reset_password_instructions
    	end
    else
    	flash[:notice] = 'Email was not found'
    	render 'new'
    end
end

end