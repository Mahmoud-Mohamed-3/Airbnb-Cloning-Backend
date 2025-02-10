require 'sidekiq'

class RemoveUserJob
  include Sidekiq::Job

  def perform(user_json)
    user_data = JSON.parse(user_json) rescue nil
    return unless user_data

    user = User.find_by(id: user_data["id"])

    if user
      # Revoke JWT tokens before deletion
      user.tokens.destroy_all if user.respond_to?(:tokens)

      if user.destroy
        Rails.logger.info "User #{user.id} deleted successfully."
      else
        Rails.logger.error "Failed to delete user with ID: #{user_data['id']}"
      end
    end
  end
end
