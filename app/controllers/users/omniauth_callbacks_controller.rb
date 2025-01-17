class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token

  def google_oauth2
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)

    if user.persisted?
      # Generate a JWT token
      token = Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
      render json: { token: token, user: user }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def failure
    render json: { error: "Authentication failed" }, status: :unauthorized
  end
end