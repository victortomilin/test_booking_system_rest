Dir["#{Rails.root}/lib/test_booking_system/lib/test_booking_system/models/*.rb"].each { |file| require file }
Dir["#{Rails.root}/lib/test_booking_system/lib/test_booking_system/helpers/*.rb"].each { |file| require file }
Dir["#{Rails.root}/lib/test_booking_system/lib/test_booking_system/validators/*.rb"].each { |file| require file }
Dir["#{Rails.root}/lib/test_booking_system/lib/test_booking_system/Interactors/*.rb"].each { |file| require file }
