require "sidekiq"
class SendPropertiesUpdatesToUsersJob
  include Sidekiq::Job

  def perform(*args)
    user = JSON.parse(args[0])
    user = User.find(user["id"])
    properties = JSON.parse(args[1])
    target_properties = Property.find(properties["id"])
    property_owner = target_properties.user_id
    target_property_owner = User.find(property_owner)
    UserMailer.with(user: user, property: target_properties, owner: target_property_owner).send_updates.deliver_now
  end
end
