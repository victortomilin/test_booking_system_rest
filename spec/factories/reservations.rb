# frozen_string_literal: true

FactoryBot.define do
  factory :reservation, class: 'TestBookingSystem::Models::Reservation' do
    start_date { Faker::Time.forward(1, :morning) }
    end_date { Faker::Time.forward(1, :evening) }
    association :user, strategy: :create
    association :table, strategy: :create
  end
end
