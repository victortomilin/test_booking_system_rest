module Api
  module V1
    class SchedulesController < ApplicationController
      before_action :set_resource, only: [:show, :update, :destroy]

      def index
        collection = ::TestBookingSystem::Models::Schedule.all
        render json: collection, each_serializer: ::ScheduleSerializer
      end

      def create
        schedule = ::TestBookingSystem::Models::Schedule.new schedule_params

        if schedule.save
          render json: schedule, serializer: ::ScheduleSerializer, status: :created
        else
          render json: { errors: schedule.errors.messages }, status: :unprocessable_entity
        end
      end

      def update
        if resource.update schedule_params
          render json: resource, serializer: ::ScheduleSerializer, status: :ok
        else
          render json: { errors: resource.errors.messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: resource, serializer: ::ScheduleSerializer
      end

      def destroy
        if resource.destroy
          render json: resource, serializer: ::ScheduleSerializer, status: :ok
        else
          render json: { errors: resource.errors.messages }, status: :unprocessable_entity
        end
      end

      private

      attr_reader :resource

      def set_resource
        @resource = ::TestBookingSystem::Models::Schedule.find params[:id]
      end

      def schedule_params
        params.require(:schedule).permit(:open_time, :close_time, :day_of_week, :restaurant_id)
      end
    end
  end
end
