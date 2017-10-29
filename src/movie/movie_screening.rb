require 'time'

# movie session class for Movie repertoire
class MovieScreening
  attr_reader :movie, :cinema_screen, :time, :available_seat_count
  def initialize(movie:, cinema_screen:, time:)
    @movie = movie
    @cinema_screen = cinema_screen
    @time = time.utc
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

  def to_s
    CinemaRepresentationHelper.stringify_screening(self)
  end

  def to_hash
    {
      movie_id: movie.object_id.to_s,
      cinema_screen_id: cinema_screen.object_id.to_s,
      time: Integer(time),
      available_seat_count: available_seat_count
    }
  end

  def self.hash_create(serial, hash)
    new(movie: serial.fetch('Movie').fetch(hash.fetch('movie_id')),
        cinema_screen: serial.fetch('CinemaScreen')
                             .fetch(hash.fetch('cinema_screen_id')),
        time: Time.at(hash.fetch('time')))
  end
end
