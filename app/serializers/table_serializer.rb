class TableSerializer < ActiveModel::Serializer
  attributes :id, :number

  belongs_to :restaurant
end
