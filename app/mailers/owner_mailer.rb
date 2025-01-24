# app/mailers/owner_mailer.rb
class OwnerMailer < ApplicationMailer
  default from: "no-reply@yourapp.com"

  def new_reservation
    @owner = params[:owner]
    @reservation = params[:reservation]
    mail(to: @owner.email, subject: "New Reservation Request")
  end
end
