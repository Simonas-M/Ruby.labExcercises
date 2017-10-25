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

  def to_json
    %({"movie_id": "#{movie.object_id}",\
    "cinema_screen_id": "#{cinema_screen.object_id}",\
    "time": "#{time.utc.to_i_to_s}",\
    "available_seat_count": #{available_seat_count}}).chomp
  end

  def self.create_from_hash(serial, hash)
    new(movie: serial['Movie'][hash['movie_id']],
        cinema_screen: serial['CinemaScreen'][hash['cinema_screen_id']],
        time: hash['time'],
        available_seat_count: hash['available_seat_count'])
  end
end
