# frozen_string_literal: true

require 'rspec/expectations'

# Custom RSpec matchers for strings
module ScreeningMatchers
  extend RSpec::Matchers::DSL
  matcher :have_reserved_seats do |seats|
    match do |screening|
      reserved = reserved_seats(screening)
      reserved == seats
    end

    failure_message do |screening|
      %(Expected movie screening #{screening}\nto have #{seats} reserved \
seats, got: #{reserved_seats(screening)})
    end

    failure_message_when_negated do |screening|
      %(Expected movie screening #{screening}\nnot to have #{seats} \
reserved seats, got: #{reserved_seats(screening)})
    end
  end

  def self.reserved_seats(screening)
    all = screening.screen.seat_count
    available = screening.available_seat_count
    all - available
  end
end
