require "sidekiq"
class SendConfirmationMailJob
  include Sidekiq::Job

  def perform(token)
    user = User.find_by(confirmation_token: token)
    return unless user && !user.confirmed?
    user.send_confirmation_instructions
  rescue StandardError => e
    Rails.logger.error("Failed to send confirmation email: #{e.message}")
  end
end
