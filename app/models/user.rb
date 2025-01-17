class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,
         :registerable,
         :confirmable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  devise :omniauthable, omniauth_providers: [ :google_oauth2 ]

  validates :first_name, presence: true
  validates :last_name, presence: true

  # File attachment validation for avatar
  has_one_attached :avatar
  validate :acceptable_avatar, if: -> { avatar.attached? }

  # Omniauth user creation method for Google OAuth2
  def self.from_omniauth(auth)
    user = find_or_initialize_by(email: auth.info.email)
    user.first_name ||= auth.info.first_name
    user.last_name ||= auth.info.last_name
    user.password ||= Devise.friendly_token[0, 20]
    user.save!
    user
  end

  # validates :google_id, uniqueness: true, allow_nil: true

  private

  # Avatar size and type validation
  def acceptable_avatar
    unless avatar.byte_size <= 1.megabyte
      errors.add(:avatar, "is too big. Max size is 1MB.")
    end

    acceptable_types = [ "image/jpeg", "image/png", "image/jpg" ]
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, "must be a JPEG, PNG, or JPG.")
    end
  end
end