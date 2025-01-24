# app/controllers/api/v1/reservations_controller.rb
module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :authenticate_user!

      def create
        @property = Property.find(params[:property_id])
        @reservation = @property.reservations.new(user: current_user)

        if @reservation.save
          send_reservation_email_to_owner(@property.user, @reservation)
          send_status_email_to_guest(@reservation.user, @reservation)
          render json: { message: "Reservation request sent successfully!", reservation: @reservation }, status: :created
        else
          render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
        end
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
