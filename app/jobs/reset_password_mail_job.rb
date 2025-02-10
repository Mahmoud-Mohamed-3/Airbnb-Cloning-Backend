require "sidekiq"

class ResetPasswordMailJob
  include Sidekiq::Job

  def perform(user_json)
    data = JSON.parse(user_json)

    user = User.find_by(id: data["id"])

    if user
      user.send_reset_password_instructions
    else
      puts "User not found!"
    end
  end
end
