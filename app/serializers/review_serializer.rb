class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :content, :cleanliness_rating, :accurancy_rating, :check_in_rating, :value_rating, :communication_rating, :location_rating, :final_rating, :user_id, :property_id

  def final_rating
    object.final_rating= (object.cleanliness_rating + object.accurancy_rating + object.check_in_rating + object.value_rating + object.communication_rating + object.location_rating) / 6
  end
end
