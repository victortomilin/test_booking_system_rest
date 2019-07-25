class CreateReservation
  include Interactor::Organizer

  organize PrepareReservationContext, TestBookingSystem::Interactors::BookTable
end
