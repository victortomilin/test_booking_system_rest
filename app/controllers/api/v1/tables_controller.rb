module Api
  module V1
    class TablesController < ApplicationController
      before_action :set_resource, only: [:show, :update, :destroy]

      def index
        collection = ::TestBookingSystem::Models::Table.all
        render json: collection, each_serializer: ::TableSerializer
      end

      def create
        table = ::TestBookingSystem::Models::Table.new table_params

        if table.save
          render json: table, serializer: ::TableSerializer, status: :created
        else
          render json: { errors: table.errors.messages }, status: :unprocessable_entity
        end
      end

      def update
        if resource.update table_params
          render json: resource, serializer: ::TableSerializer, status: :ok
        else
          render json: { errors: resource.errors.messages }, status: :unprocessable_entity
        end
      end

      def show
        render json: resource, serializer: ::TableSerializer
      end

      def destroy
        if resource.destroy
          render json: resource, serializer: ::TableSerializer, status: :ok
        else
          render json: { errors: resource.errors.messages }, status: :unprocessable_entity
        end
      end

      private

      attr_reader :resource

      def set_resource
        @resource = ::TestBookingSystem::Models::Table.find params[:id]
      end

      def table_params
        params.require(:table).permit(:number, :restaurant_id)
      end
    end
  end
end
