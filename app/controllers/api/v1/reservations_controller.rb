# app/controllers/api/v1/reservations_controller.rb
module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :authenticate_user!

      def create
        @property = Property.find_by(id: params[:property_id])
        return render_not_found("Property not found") unless @property

        if existing_reservation?
          return render_conflict("You have already made a reservation for this property")
        end

        @reservation = @property.reservations.new(reservation_params.merge(user: current_user, status: "pending"))

        if @reservation.save
          send_reservation_emails(@reservation)
          render_created("Reservation request sent successfully!", @reservation)
        else
          render_unprocessable_entity(@reservation.errors.full_messages)
        end
      end

      def owner_reservations
        @reservations = pending_reservations_for_owner
        render json: @reservations, each_serializer: ReservationSerializer
      end

      def update_status
        @reservation = Reservation.find(params[:id])
        if @reservation.update(status: params[:status])
          send_status_email_to_guest(@reservation.user, @reservation)
          render_ok("Reservation #{params[:status]}!", @reservation)
        else
          render_unprocessable_entity(@reservation.errors.full_messages)
        end
      end

      private
      def reservation_params
        params.require(:reservation).permit(:start_date, :end_date, :total_price).tap do |whitelisted|
          whitelisted[:start_date] = Date.strptime(whitelisted[:start_date], "%Y-%m-%d") rescue nil
          whitelisted[:end_date] = Date.strptime(whitelisted[:end_date], "%Y-%m-%d") rescue nil
        end
      end
      def existing_reservation?
        Reservation.exists?(property_id: @property.id, user_id: current_user.id, status: "pending")
      end


      def pending_reservations_for_owner
        Reservation.joins(:property)
                   .where(properties: { user_id: current_user.id })
                   .where.not(status: [ "approved", "rejected" ])
      end

      def send_reservation_emails(reservation)
        send_reservation_email_to_owner(reservation.property.user, reservation)
        send_reservation_email_to_guest(reservation.user, reservation)
      end

      def send_reservation_email_to_owner(owner, reservation)
        @owner = owner.to_json
        @reservation = reservation.to_json
        # OwnerMailer.with(owner: owner, reservation: @reservation).new_reservation.deliver_now
        SendReservationEmailsJob.perform_async(@owner, @reservation)
      end

      def send_reservation_email_to_guest(guest, reservation)
        @guest = guest.to_json
        @reservation = reservation.to_json
        SendReservationMailToGuestJob.perform_async(@guest, @reservation)
      end

      def send_status_email_to_guest(guest, reservation)
        @guest = guest.to_json
        @reservation = reservation.to_json
        SendStatusMailToGuestJob.perform_async(@guest, @reservation)
        # GuestMailer.with(guest: guest, reservation: reservation).reservation_status.deliver_now
      end

      def render_not_found(message)
        render json: { error: message }, status: :not_found
      end

      def render_conflict(message)
        render json: { error: message }, status: :conflict
      end

      def render_created(message, reservation)
        render json: { message: message, reservation: reservation }, status: :created
      end

      def render_ok(message, reservation)
        render json: { message: message, reservation: reservation }, status: :ok
      end

      def render_unprocessable_entity(errors)
        render json: { errors: errors }, status: :unprocessable_entity
      end
    end
  end
end
