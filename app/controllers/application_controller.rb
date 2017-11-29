class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:email, :name, :password, :password_confirmation, :remember_me, :accept])
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to login_path
    end
  end

  before_filter :set_cache_headers

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
