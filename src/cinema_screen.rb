# class for movie screen
class CinemaScreen
  attr_reader :id, :name, :seat_count, :available_seat_count
  def initialize(id:, name:, seat_count:)
    @id = id
    @name = name
    @seat_count = seat_count
    @available_seat_count = @seat_count
  end

  def reserve(seat_count)
    raise 'not enough free seats available' unless
      seat_count.to_i <= @available_seat_count
    @available_seat_count -= seat_count.to_i
  end

  def free(seat_count)
    raise "max seats to free:#{@seat_count - @available_seat_count}" unless
    seat_count.to_i <= (@seat_count - @available_seat_count)
    @available_seat_count += seat_count.to_i
  end
end
