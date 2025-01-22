class PropertySerializer < ActiveModel::Serializer
  attributes :id, :city, :country, :price, :duration, :description, :owner, :images, :property_rate

  def property_rate
    object.property_rating
  end

  def images
    object.images.map { |image| Rails.application.routes.url_helpers.rails_blob_url(image, host: "http://localhost:3000") }
  end
end
