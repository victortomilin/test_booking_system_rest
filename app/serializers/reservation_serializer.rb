# frozen_string_literal: true

class ReservationSerializer < ActiveModel::Serializer
  attributes :start_date, :end_date

  belongs_to :user
  belongs_to :table
end
