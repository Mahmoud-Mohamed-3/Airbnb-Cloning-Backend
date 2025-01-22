class Property < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many_attached :images
  validates :description, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :duration, presence: true
  validates :price, presence: true
  # validates :owner, presence: true
  validate :acceptable_images


  def property_rating
    return 0 if reviews.empty? # Return 0 if there are no reviews

    # Calculate the average final_rating from all reviews
    reviews.average(:final_rating).to_f.round(1) # Round to 1 decimal place
  end


  private


  def acceptable_images
    return unless images.attached?

    images.each do |image|
      unless image.byte_size <= 3.megabyte
        errors.add(:images, "is too big. Max size is 3MB.")
      end

      acceptable_types = [ "image/jpeg", "image/png", "image/jpg", "image/avif" ]
      unless acceptable_types.include?(image.content_type)
        errors.add(:images, "must be a JPEG, PNG, or JPG.")
      end
    end
  end
end
