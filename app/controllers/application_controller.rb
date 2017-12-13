class ApplicationController < ActionController::Base
  acts_as_token_authentication_handler_for User
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_timezone
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  before_action :set_cache_headers
  skip_before_action :verify_authenticity_token, if: :json_request?

  protected

  def json_request?
    request.format.json?
  end

  def after_sign_in_path_for(resource)
      if resource.sign_in_count == 1
         add_city_path
      else
         root_path
      end
  end

  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:email, :name, :password, :password_confirmation, :remember_me, :accept])
    devise_parameter_sanitizer.permit(:account_update, keys:[:email, :name, :city, :password, :password_confirmation, :current_password])
  end

  def authenticate_user!(options={})
    if user_signed_in?
      super(options)
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

  def set_timezone  
    min = cookies[:time_zone].to_i
    Time.zone = ActiveSupport::TimeZone[-min]
  end 

end
