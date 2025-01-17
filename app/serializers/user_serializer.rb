class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :profile_image_url

  def profile_image_url
    if object.profile_image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.profile_image, host: "http://localhost:3000")
    else
      nil
    end
  end
end
