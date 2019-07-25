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

  # I had like to have a understandable error messages on the frontend side.
  # I hate messages such as `Couldn't find TestBookingSystem::Models::User with 'id'=0`, it's looks quite stupid

  def fetch_user
    raise Exception.new "User is not defined." if context.user_id.blank?
    begin
      TestBookingSystem::Models::User.find context.user_id
    rescue ActiveRecord::RecordNotFound
      raise Exception.new "User is not exist."
    end
  end

  def fetch_table
    raise Exception.new "Table is not defined." if context.table_id.blank?
    begin
      TestBookingSystem::Models::Table.find context.table_id
    rescue ActiveRecord::RecordNotFound
      raise Exception.new "Table is not exist."
    end
  end

  def prepare_date
    raise Exception.new "Reservation date is not defined." if context.date.blank?
    begin
      DateTime.parse context.date
    rescue Exception
      raise Exception.new "Reservation date has a bad format."
    end
  end

  def prepare_duration
    raise Exception.new "Reservation duration is not defined." if context.duration.blank?
    context.duration.to_i
  end
end
