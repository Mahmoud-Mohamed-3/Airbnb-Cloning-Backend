class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :profile_image_url,
             :user_whishlisted_properties, :user_reservations, :user_reviews,
             :user_properties, :user_received_reviews, :user_received_reservations,
             :owner

  def user_whishlisted_properties
    object.user_whishlisted_properties
  end

  def user_reservations
    object.user_reservations
  end

  def user_reviews
    object.user_reviews
  end

  def user_properties
    object.user_properties
  end

  def user_received_reviews
    object.user_received_reviews
  end

  def user_received_reservations
    object.user_received_reservations
  end

  def profile_image_url
    if object.profile_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.profile_image, host: "http://localhost:3000")
    else
      nil
    end
  end

  # New action: owner
  def owner
    {
      first_name: object.first_name,
      profile_image_url: profile_image_url
    }
  end
end
