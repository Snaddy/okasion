class Api::V1::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_action :verify_authenticity_token

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @graph = Koala::Facebook::API.new(request.headers['OAuth'])
      auth = Hash.new
      auth[:provider] = 'facebook'
      auth[:uid] = request.headers['Uid']
      auth[:email] = @graph.get_object("me", fields: 'email')
      auth[:name] = @graph.get_object("me", fields: 'name')

      puts auth

    @user = User.from_omniauth_api(auth)

    if @user.persisted?
      sign_in(@user)#this will throw if @user is not activated
      render json: { status: "success" }
    else
      render json: { status: @user.errors.full_messages.join("\n") }
    end
  end

  # def google_oauth2
  #     @user = User.from_omniauth(request.env['omniauth.auth'])

  #     if @user.persisted?
  #       flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
  #       sign_in_and_redirect @user, event: :authentication
  #     else
  #       session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
  #       redirect_to new_user_session_url, alert: @user.errors.full_messages.join("\n")
  #     end
  # end

  def failure
    redirect_to root_path
  end

end