class Review < ApplicationRecord
  belongs_to :user
  belongs_to :property
  validates :content, presence: true
  validates :cleanliness_rating, presence: true, numericality: {  greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :accurancy_rating, presence: true, numericality: {  greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :check_in_rating, presence: true, numericality: {  greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :value_rating, presence: true, numericality: {  greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :communication_rating, presence: true, numericality: {  greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :location_rating, presence: true, numericality: {  greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :final_rating, presence: true, numericality: {  greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  def review_writer
    render json: user, serializer: UserSerializer
  end
end
