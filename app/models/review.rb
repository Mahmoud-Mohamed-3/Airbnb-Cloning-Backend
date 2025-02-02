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
end

# def review_writer
#   {
#     review: self.as_json(except: [:user_id]), # Avoid serializing the user_id to prevent circular references
#     user: self.user.as_json(only: [:first_name, :last_name]).merge(profile_image: self.user.url_for(:profile_image)) # Add the profile_image URL
#   }
# end



# def review_writer
#   reviews.map do |review|
#     review.includes(:user, :property) # Ensure the user and property are loaded for each review
#     {
#       id: review.id,
#       user_id: review.user_id,
#       property_id: review.property_id,
#       content: review.content,
#       cleanliness_rating: review.cleanliness_rating,
#       accurancy_rating: review.accurancy_rating,
#       check_in_rating: review.check_in_rating,
#       value_rating: review.value_rating,
#       communication_rating: review.communication_rating,
#       location_rating: review.location_rating,
#       final_rating: review.final_rating,
#       first_name: review.user.first_name,
#       last_name: review.user.last_name,
#       user_email: review.user.email,
#       city: review.property.city,
#       country: review.property.country,
#       user_profile_image: review.user.profile_image.attached? ? url_for(review.user.profile_image) : nil # Generate URL only if image is attached
#     }
#   end
# end
# end

# properties.map do |property|
#   property.reservations
#           .where(status: "pending")
#           .includes(:user) # Ensure the user is loaded for each reservation
#           .map do |reservation|
#     {
#       id: reservation.id,
#       user_id: reservation.user_id,
#       property_id: reservation.property_id,
#       status: reservation.status,
#       start_date: reservation.start_date,
#       end_date: reservation.end_date,
#       total_price: reservation.total_price,
#       user_first_name: reservation.user.first_name,
#       user_last_name: reservation.user.last_name,
#       user_email: reservation.user.email,
#       city: reservation.property.city,
#       country: reservation.property.country,
#       user_profile_image: reservation.user.profile_image.attached? ? url_for(reservation.user.profile_image) : nil # Generate URL only if image is attached
#     }
#   end
# end.flatten!
