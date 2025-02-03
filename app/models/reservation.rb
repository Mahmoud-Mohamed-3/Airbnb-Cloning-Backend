# app/models/reservation.rb
class Reservation < ApplicationRecord
  belongs_to :property
  belongs_to :user

  enum :status, { pending: "pending", approved: "approved", rejected: "rejected", canceled: "canceled" }
  def number_of_days
    return 0 unless start_date.present? && end_date.present?
    (end_date.to_date - start_date.to_date).to_i
  end
end
