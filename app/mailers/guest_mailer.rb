# app/mailers/guest_mailer.rb
class GuestMailer < ApplicationMailer
  default from: "no-reply@yourapp.com"

  def reservation_request
    @guest = params[:guest]
    @reservation = params[:reservation]
    mail(to: @guest.email, subject: "Reservation Request Submitted")
  end

  def reservation_status
    @guest = params[:guest]
    @reservation = params[:reservation]
    mail(to: @guest.email, subject: "Reservation #{@reservation.status.capitalize}")
  end
end
