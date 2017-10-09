# movie session class for Movie repertoire
class MovieScreening
  attr_reader :movie, :cinema_screen, :time, :available_seat_count
  def initialize(movie:, cinema_screen:, time:)
    @movie = movie
    @cinema_screen = cinema_screen
    @time = time
    @available_seat_count = cinema_screen.seat_count
  end

  def reserve(seat_count)
    seat_count = Integer(seat_count)
    raise 'not enough free seats available' unless
      seat_count <= available_seat_count
    @available_seat_count -= seat_count
  end

  def free(seat_count)
    seat_count = Integer(seat_count)
    raise "cannon free #{seat_count} seats" unless
    seat_count <= (cinema_screen.seat_count - available_seat_count)
    @available_seat_count += seat_count
  end

  def available?(seat_count)
    seat_count <= available_seat_count
  end
end
