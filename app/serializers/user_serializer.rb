class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :avatar_url

  def avatar_url
    if object.avatar.attached?
      Rails.application.routes.url_helpers.rails_blob_url(object.avatar, host: "http://localhost:3000")
    else
      nil
    end
  end
end