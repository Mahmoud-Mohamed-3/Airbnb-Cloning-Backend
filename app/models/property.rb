class Property < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  validates :description, presence: true
  # validates :owner, presence: true
  validate :acceptable_images

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
