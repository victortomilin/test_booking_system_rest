# frozen_string_literal: true

FactoryBot.define do
  factory :restaurant, class: 'TestBookingSystem::Models::Restaurant' do
    name { Faker::Name.unique.name }
  end
end
