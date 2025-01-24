# app/mailers/guest_mailer.rb
class GuestMailer < ApplicationMailer
  default from: "no-reply@yourapp.com"

  # Email sent to the guest when they create a reservation
  def reservation_request
    @guest = params[:guest]
    @reservation = params[:reservation]
    mail(to: @guest.email, subject: "Reservation Request Submitted")
  end

  # Email sent to the guest when the reservation status is updated
  def reservation_status
    @guest = params[:guest]
    @reservation = params[:reservation]
    mail(to: @guest.email, subject: "Reservation #{@reservation.status.capitalize}")
  end
end
