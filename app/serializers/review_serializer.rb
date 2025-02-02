class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :content, :cleanliness_rating, :accurancy_rating, :check_in_rating, :value_rating, :communication_rating, :location_rating, :final_rating, :user_id, :property_id, :review_writer

  def final_rating
    object.final_rating= (object.cleanliness_rating + object.accurancy_rating + object.check_in_rating + object.value_rating + object.communication_rating + object.location_rating) / 6
  end

  def review_writer
    full_name = "#{object.user.first_name} #{object.user.last_name}"
    profile_image_url = object.user.profile_image.attached? ? Rails.application.routes.url_helpers.rails_blob_url(object.user.profile_image):nil

    {
      full_name: full_name,
      profile_image_url: profile_image_url
    }
  end
end
