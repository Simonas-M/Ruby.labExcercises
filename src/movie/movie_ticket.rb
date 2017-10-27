require_relative './movie_screening.rb'

# Motie ticket class for
class MovieTicket
  attr_reader :price, :movie_screening, :seat_no
  def initialize(price:, movie_screening:, seat_no:)
    raise 'MovieScreening object expected' unless
      movie_screening.class.equal?(MovieScreening)
    @price = Float(price)
    @movie_screening = movie_screening
    @seat_no = Integer(seat_no)
  end

  def to_json
    %({"price": #{price},\
    "movie_screening_id": "#{movie_screening.object_id}",\
    "seat_no": #{seat_no}})
  end

  def self.hash_create(serial, hash)
    new(price: hash.fetch(:price),
        movie_screening: serial.fetch(:MovieScreening)
                               .fetch(hash.fetch(:movie_screening_id)),
        seat_no: hash.fetch(:seat_no))
  end
end
