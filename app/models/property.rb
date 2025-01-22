class Property < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many_attached :images

  # Validations
  validates :description, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :price, presence: true
  validate :acceptable_images
  validate :start_date, on: :create
  validate :end_date, on: :create
  validate :start_date_before_end_date, on: :create
  validate :start_date_not_in_past, on: :create
  validate :end_date_after_start_date, on: :create

  # Methods for calculating average ratings
  def property_rating
    return 0 if reviews.empty?
    reviews.average(:final_rating).to_f.round(1)
  end

  def ave_cleanliness
    return 0 if reviews.empty?
    reviews.average(:cleanliness_rating).to_f.round(1)
  end

  def ave_accurancy
    return 0 if reviews.empty?
    reviews.average(:accurancy_rating).to_f.round(1)
  end

  def ave_check_in
    return 0 if reviews.empty?
    reviews.average(:check_in_rating).to_f.round(1)
  end

  def ave_value
    return 0 if reviews.empty?
    reviews.average(:value_rating).to_f.round(1)
  end

  def ave_communication
    return 0 if reviews.empty?
    reviews.average(:communication_rating).to_f.round(1)
  end

  def ave_location
    return 0 if reviews.empty?
    reviews.average(:location_rating).to_f.round(1)
  end

  private

  # Custom validation: Ensure images are acceptable
  def acceptable_images
    return unless images.attached?

    images.each do |image|
      unless image.byte_size <= 3.megabyte
        errors.add(:images, "is too big. Max size is 3MB.")
      end

      acceptable_types = ["image/jpeg", "image/png", "image/jpg", "image/avif"]
      unless acceptable_types.include?(image.content_type)
        errors.add(:images, "must be a JPEG, PNG, or JPG.")
      end
    end
  end

  # Custom validation: Ensure start_date is before end_date
  def start_date_before_end_date
    return if start_date.blank? || end_date.blank?

    if start_date >= end_date
      errors.add(:start_date, "must be before end date")
    end
  end

  # Custom validation: Ensure start_date is not in the past
  def start_date_not_in_past
    return if start_date.blank?

    if start_date < Date.today
      errors.add(:start_date, "cannot be in the past")
    end
  end

  # Custom validation: Ensure end_date is after start_date
  def end_date_after_start_date
    return if start_date.blank? || end_date.blank?

    if end_date <= start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end