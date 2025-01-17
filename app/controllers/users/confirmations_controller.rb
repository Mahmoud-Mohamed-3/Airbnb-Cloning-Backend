# frozen_string_literal: true

# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  def new
    self.resource = resource_class.new
  end

  # POST /resource/confirmation
  def create
    # Extract the confirmation parameters (email and token)
    confirmation_params = params.require(:confirmation).permit(:token)

    # Send confirmation instructions to the resource
    self.resource = resource_class.send_confirmation_instructions(confirmation_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
    else
      # Log any errors for troubleshooting
      Rails.logger.error("Confirmation errors: #{resource.errors.full_messages.join(', ')}") if resource.errors.any?
      respond_with(resource)
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    # Attempt to confirm the user with the provided token
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      # Automatically confirm the user
      resource.update(confirmed_at: Time.current, confirmation_token: nil)

      # Log confirmation success
      # Rails.logger.info("User #{resource.email} automatically confirmed.")
      #
      # # set_flash_message!(:notice, :confirmed)
      # respond_with_navigational(resource) { redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      # Log the errors for troubleshooting
      Rails.logger.error("Confirmation failed for token: #{params[:confirmation_token]}")

      # # Handle invalid token (or other errors) by rendering the confirmation page again
      # set_flash_message!(:alert, :invalid_token)
      # respond_with_navigational(resource.errors, status: :unprocessable_entity) { render :new }
    end
  end

  protected
  #
  # # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   is_navigational_format? ? new_session_path(resource_name) : '/'
  # end
  #
  # # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   if signed_in?(resource_name)
  #     signed_in_root_path(resource)
  #   else
  #     new_session_path(resource_name)
  #   end
  # end
  #
  def translation_scope
    "devise.confirmations"
  end
end
