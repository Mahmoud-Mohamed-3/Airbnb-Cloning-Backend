require "sidekiq"
class SendReservationMailToGuestJob
  include Sidekiq::Job

  def perform(*args)
    guest = JSON.parse(args[0])
    user = User.find(guest["id"])
    reservation = JSON.parse(args[1])
    target_reservation = Reservation.find(reservation["id"])
    GuestMailer.with(guest: user, reservation: target_reservation).reservation_request.deliver_now
  end
end
