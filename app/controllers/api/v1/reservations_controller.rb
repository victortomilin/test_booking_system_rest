# frozen_string_literal: true

module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :set_resource, only: %i[show destroy]

      def index
        collection = ::TestBookingSystem::Models::Reservation.all
        render json: collection, each_serializer: ::ReservationSerializer
      end

      def create
        result = CreateReservation.call reservation_params
        if result.success?
          render json: result.reservation, serializer: ::ReservationSerializer, status: :created
        else
          render json: { errors: result.message }, status: :unprocessable_entity
        end
      end

      def show
        render json: resource, serializer: ::ReservationSerializer
      end

      def destroy
        if resource.destroy
          render json: resource, serializer: ::ReservationSerializer, status: :ok
        else
          render json: { errors: resource.errors.messages }, status: :unprocessable_entity
        end
      end

      private

      attr_reader :resource

      def set_resource
        @resource = ::TestBookingSystem::Models::Reservation.find params[:id]
      end

      def reservation_params
        params.require(:reservation).permit(:date, :duration, :user_id, :table_id)
      end
    end
  end
end
