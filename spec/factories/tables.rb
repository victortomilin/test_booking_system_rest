FactoryBot.define do
  factory :table, class: "TestBookingSystem::Models::Table" do
    number { Faker::Number.number(2) }
    association :restaurant, strategy: :create
  end
end
