require "sidekiq"
class SendPropertiesUpdatesToUsersJob
  include Sidekiq::Job

  def perform(*args)
    user = JSON.parse(args[0])
    user = User.find(user["id"])
    properties = JSON.parse(args[1])
    target_properties = Property.find(properties["id"])
    UserMailer.with(user: user, property: target_properties).send_updates.deliver_now
  end
end
