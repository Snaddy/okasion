class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    redirect_to login_path
    flash[:notice] = 'Thanks for confirming your email!'
  end
end