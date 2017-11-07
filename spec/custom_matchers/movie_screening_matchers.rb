require 'rspec/expectations'

# Custom RSpec matchers for strings
module MovieScreeningMatchers
  extend RSpec::Matchers::DSL
  matcher :have_reserved_seats do |seats|
    match do |movie_screening|
      reserved = reserved_seats(movie_screening)
      reserved == seats
    end

    failure_message do |movie_screening|
      %(Expected movie screening #{movie_screening}\nto have #{seats} reserved \
seats, got: #{reserved_seats(movie_screening)})
    end

    failure_message_when_negated do |movie_screening|
      %(Expected movie screening #{movie_screening}\nnot to have #{seats} \
reserved seats, got: #{reserved_seats(movie_screening)})
    end
  end

  def reserved_seats(movie_screening)
    all = movie_screening.cinema_screen.seat_count
    available = movie_screening.available_seat_count
    all - available
  end
end
