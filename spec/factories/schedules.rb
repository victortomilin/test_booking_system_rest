FactoryBot.define do
  factory :schedule, class: "TestBookingSystem::Models::Schedule" do
    day_of_week { Faker::Number.between(1, 7) }
    open_time { Faker::Time.forward(1, :morning) }
    close_time { Faker::Time.forward(1, :evening) }
    association :restaurant, strategy: :create
  end
end
