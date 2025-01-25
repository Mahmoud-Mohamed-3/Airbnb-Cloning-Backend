class PropertySerializer < ActiveModel::Serializer
  # attributes :id, :city, :country, :price, :start_date, :end_date, :description, :owner, :images, :property_rate, :ave_cleanliness, :ave_accurancy, :ave_check_in, :ave_value, :ave_communication, :ave_location, :user_id , :type, :place, :max_guests, :beds, :bedrooms, :baths

  attributes :id, :city, :country, :price, :start_date, :end_date, :description, :owner, :images, :property_rate, :ave_cleanliness, :ave_accurancy, :ave_check_in, :ave_value, :ave_communication, :ave_location, :user_id, :type_of_property, :place, :max_guests, :beds, :bedrooms, :baths

  def attributes(*args)
    hash = super
    # Exclude certain attributes for the index action
    if instance_options[:action] == :index
      hash.except!(:description,    :ave_cleanliness, :ave_accurancy, :ave_check_in, :ave_value, :ave_communication, :ave_location,  :type, :place, :max_guests,  :bedrooms, :baths)
    end
    hash
  end
  def property_rate
    object.property_rating
  end
  def ave_cleanliness
    object.ave_cleanliness
  end
  def ave_accurancy
    object.ave_accurancy
  end
  def ave_check_in
    object.ave_check_in
  end
  def ave_value
    object.ave_value
  end
  def ave_communication
    object.ave_communication
  end
  def ave_location
    object.ave_location
  end


  def images
    object.images.map { |image| Rails.application.routes.url_helpers.rails_blob_url(image, host: "http://localhost:3000") }
  end
end
