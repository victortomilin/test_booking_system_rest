# frozen_string_literal: true

class ScheduleSerializer < ActiveModel::Serializer
  attributes :open_time, :close_time, :day_of_week

  belongs_to :restaurant
end
