# app/controllers/api/v1/reservations_controller.rb
module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :authenticate_user!

      def create
        # Find the property
        @property = Property.find_by(id: params[:property_id])

        # Check if the property exists
        unless @property
          return render json: { error: "Property not found" }, status: :not_found
        end

        # Check if the user has already made a reservation for this property
        @checkReservation = Reservation.where(property_id: @property.id, user_id: current_user.id, status: "pending")
        if @checkReservation.exists?
          return render json: { error: "You have already made a reservation for this property" }, status: :conflict
        end

        # Create a new reservation
        @reservation = @property.reservations.new(user: current_user)

        # Save the reservation
        if @reservation.save
          # Send emails to the owner and guest
          send_reservation_email_to_owner(@property.user, @reservation)
          send_reservation_email_to_guest(@reservation.user, @reservation)

          # Return success response
          render json: { message: "Reservation request sent successfully!", reservation: @reservation }, status: :created
        else
          # Return error response if the reservation fails to save
          render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
        end
      end
      def owner_reservations
        @reservations = Reservation.joins(:property).where(properties: { user_id: current_user.id }).reject { |reservation| reservation.status == "approved"|| reservation.status == "rejected" }
        render json: @reservations, each_serializer: ReservationSerializer
      end
      def update_status
        @reservation = Reservation.find(params[:id])
        if @reservation.update(status: params[:status])
          # Send email to the guest (user who made the reservation)
          send_status_email_to_guest(@reservation.user, @reservation)
          render json: { message: "Reservation #{params[:status]}!", reservation: @reservation }, status: :ok
        else
          render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def send_reservation_email_to_owner(owner, reservation)
        OwnerMailer.with(owner: owner, reservation: reservation).new_reservation.deliver_now
      end

      def send_reservation_email_to_guest(guest, reservation)
        GuestMailer.with(guest: guest, reservation: reservation).reservation_request.deliver_now
      end

      def send_status_email_to_guest(guest, reservation)
        GuestMailer.with(guest: guest, reservation: reservation).reservation_status.deliver_now
      end
    end
  end
end
