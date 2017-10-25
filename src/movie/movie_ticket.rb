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
    %({"price": "#{price}",\
    "movie_screening_id": "#{movie_screening.object_id}",\
    "seat_no": #{seat_no}}).chomp
  end

  def self.create_from_hash(serial, hash)
    new(price: hash['price'],
        movie_screening: serial['MovieScreening'][hash['movie_screening_id']],
        seat_no: hash['seat_no'])
  end
end
