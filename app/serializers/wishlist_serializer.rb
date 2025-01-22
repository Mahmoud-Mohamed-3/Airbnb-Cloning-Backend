class WishlistSerializer < ActiveModel::Serializer
  attributes :id, :property_id, :user_id
end
