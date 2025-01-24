# app/models/reservation.rb
class Reservation < ApplicationRecord
  belongs_to :property
  belongs_to :user

  enum :status, { pending: "pending", approved: "approved", rejected: "rejected", canceled: "canceled" }
end
