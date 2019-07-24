FactoryBot.define do
  factory :restaurant, class: "TestBookingSystem::Models::Restaurant" do
    name { Faker::Name.name }
  end
end
