# class for movie screen
class CinemaScreen
  attr_reader :name, :seat_count
  def initialize(name:, seat_count:)
    @name = name
    @seat_count = seat_count
  end

  def ==(other)
    @name == other.name &&
      @seat_count == other.seat_count
  end
end
