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
end
