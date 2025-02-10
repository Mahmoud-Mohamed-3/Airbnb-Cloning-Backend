require "sidekiq"
class SendReservationEmailsJob
  include Sidekiq::Job

  def perform(*args)
    # puts " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{ args[0] }"
    owner = JSON.parse(args[0])
    user = User.find(owner["id"])
    reservation = JSON.parse(args[1])
    target_reservation = Reservation.find(reservation["id"])
    # puts " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{ user }"
    # puts " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{ owner["id"] }"
    # @reservation = JSON.parse(args[1]["id"])
    # puts " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{ @owner }"
    # puts " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{ @reservation }"
    OwnerMailer.with(owner: user, reservation: target_reservation).new_reservation.deliver_now
    # puts " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>#{ args[1] }"
  end
end
