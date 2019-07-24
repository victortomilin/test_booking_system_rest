FactoryBot.define do
  factory :schedule, class: "TestBookingSystem::Models::Schedule" do
    sequence :day_of_week
    open_time { Time.new(1, 1, 1, 10, 30, 0) }
    close_time { Time.new(1, 1, 1, 22, 30, 0) }
    association :restaurant, strategy: :create
  end
end
