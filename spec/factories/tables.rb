FactoryBot.define do
  factory :table, class: "TestBookingSystem::Models::Table" do
    number { Faker::Number.number(2) }
    association :restaurant, strategy: :create
  end

  factory :table_with_schedules, parent: :table do
    association :restaurant, factory: :special_restaurant, strategy: :create

    factory :special_restaurant, parent: :restaurant do
      after :create do |restaurant|
        create_list :schedule, 7, restaurant: restaurant
      end
    end
  end
end
