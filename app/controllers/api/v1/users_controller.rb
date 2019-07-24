module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_resource, only: [:show, :destroy]

      def index
        collection = ::TestBookingSystem::Models::User.all
        render json: collection, each_serializer: ::UserSerializer
      end

      def create
        user = ::TestBookingSystem::Models::User.new

        if user.save
          render json: user, serializer: ::UserSerializer, status: :created
        else
          render json: { errors: user.errors.messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: resource, serializer: ::UserSerializer
      end

      def destroy
        if resource.destroy
          render json: resource, serializer: ::UserSerializer, status: :ok
        else
          render json: { errors: resource.errors }, status: :unprocessable_entity
        end
      end

      private

      attr_reader :resource

      def set_resource
        @resource = ::TestBookingSystem::Models::User.find params[:id]
      end
    end
  end
end
