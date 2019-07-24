module Api
  module V1
    class RestaurantsController < ApplicationController
      before_action :set_resource, only: [:show, :update, :destroy]

      def index
        collection = ::TestBookingSystem::Models::Restaurant.all
        render json: collection, each_serializer: ::RestaurantSerializer
      end

      def create
        restaurant = ::TestBookingSystem::Models::Restaurant.new restaurant_params

        if restaurant.save
          render json: restaurant, serializer: ::RestaurantSerializer, status: :created
        else
          render json: { errors: restaurant.errors.messages }, status: :unprocessable_entity
        end
      end

      def update
        if resource.update restaurant_params
          render json: resource, serializer: ::RestaurantSerializer, status: :ok
        else
          render json: { errors: resource.errors.messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: resource, serializer: ::RestaurantSerializer
      end

      def destroy
        if resource.destroy
          render json: resource, serializer: ::RestaurantSerializer, status: :ok
        else
          render json: { errors: resource.errors.messages }, status: :unprocessable_entity
        end
      end

      private

      attr_reader :resource

      def set_resource
        @resource = ::TestBookingSystem::Models::Restaurant.find params[:id]
      end

      def restaurant_params
        params.require(:restaurant).permit(:name)
      end
    end
  end
end
