class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix
  respond_to :json

  private

  # Permit additional parameters for sign up
  def sign_up_params
    params.require(:user).permit(:email, :password,  :avatar, :first_name, :last_name)
  end

  # Permit additional parameters for account update (if applicable)
  def account_update_params
    params.require(:user).permit(:email, :password, :current_password, :avatar, :first_name, :last_name)
  end

  # Respond to different actions
  def respond_with(resource, _opts = {})
    if request.method == "POST" && resource.persisted?
      render json: {
        message: "Signed up successfully.",
        data: resource
      }, status: :ok
    elsif request.method == "DELETE"
      render json: {
        message: "Account deleted successfully."
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end
end