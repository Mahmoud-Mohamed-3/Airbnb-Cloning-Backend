class Users::SessionsController < Devise::SessionsController
  include RackSessionFix
  respond_to :json

  require "open-uri"

  def create
    if params[:google_token].present?
      handle_google_sign_in
    else
      super
    end
  end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        message: "Logged in successfully.",
        data: user_data(resource)
      }, status: :ok
    else
      render json: {
        message: "Login failed. Invalid credentials."
      }, status: :unauthorized
    end
  end


  def respond_to_on_destroy
    if current_user
      sign_out(current_user)
      render json: { message: "Logged out successfully" }, status: :ok
    else
      render json: { message: "Couldn't find an active session." }, status: :unauthorized
    end
  end

  def handle_google_sign_in
    token = params[:google_token]

    validator = GoogleIDToken::Validator.new
    begin
      payload = validator.check(token, "572508878231-ritv9flo5nbv3rsbr480f7ommvfkl8a3.apps.googleusercontent.com")

      email = payload["email"]
      first_name = payload["given_name"]
      last_name = payload["family_name"]
      profile_image_url = payload["picture"]

      user = User.find_or_initialize_by(email: email)
      if user.new_record?
        user.first_name = first_name
        user.last_name = last_name
        user.password = Devise.friendly_token[0, 20]

        if profile_image_url.present?
          user.profile_image.attach(io: URI.open(profile_image_url), filename: "#{email}_image.jpg", content_type: "image/jpeg")
        end

        unless user.save
          render json: { message: "Error creating user", errors: user.errors.full_messages }, status: :unprocessable_entity
          return
        end
      else
        if profile_image_url.present? && !user.profile_image.attached?
          user.profile_image.attach(io: URI.open(profile_image_url), filename: "#{email}_image.jpg", content_type: "image/jpeg")
        end
      end

      sign_in(user)

      render json: { message: "Logged in successfully with Google.", data: user_data(user) }, status: :ok
    rescue GoogleIDToken::ValidationError => e
      render json: { message: "Invalid Google token: #{e.message}" }, status: :unauthorized
    end
  end

  def user_data(user)
    {
      id: user.id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name,
      profile_image_url: user.profile_image.attached? ? rails_blob_url(user.profile_image, host: "http://localhost:3000") : nil
    }
  end
end
