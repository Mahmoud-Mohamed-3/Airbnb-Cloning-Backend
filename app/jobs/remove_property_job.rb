require "sidekiq"

class RemovePropertyJob
  include Sidekiq::Job

  def perform(property_json)
    property_data = JSON.parse(property_json) rescue nil
    return unless property_data

    property = Property.find_by(id: property_data["id"])
    if property&.destroy
      Rails.logger.info "Property #{property.id} deleted successfully"
    else
      Rails.logger.error "Failed to delete property with ID: #{property_data['id']}"
    end
  end
end
