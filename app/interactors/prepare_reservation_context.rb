class PrepareReservationContext
  include Interactor

  def call
    begin
      context.user = fetch_user
      context.table = fetch_table
      context.date = prepare_date
      context.duration = prepare_duration
    rescue Exception => error
      context.fail! message: error.to_s
    end
  end

  private

  def fetch_user
    TestBookingSystem::Models::User.find context.user_id
  end

  def fetch_table
    TestBookingSystem::Models::Table.find context.table_id
  end

  def prepare_date
    DateTime.parse context.date
  end

  def prepare_duration
    context.duration.to_i
  end
end
