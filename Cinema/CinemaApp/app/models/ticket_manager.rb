# frozen_string_literal: true

# Class for managing bought tickets
class TicketManager < ApplicationRecord
  belongs_to :cinema
  has_many :tickets

  BASE_PRICE = 3
  BASE_DISCOUNT = 0.087
  BASE_DISCOUNT_START = 3

  # def reserve_ticket(client, ticket)

  # end

  def get_clients_tickets(client)
    tickets.where { |ticket| ticket.client == client }
  end

  def create_ticket(screening:, seat_no:)
    Ticket.create(
      price: 123,
      seat_no: seat_no,
      screening_id: screening,
      ticket_manager_id: id
    )
  end

  def assign_ticket(ticket:, client:)
    raise 'cannon reassign ticket' if ticket.client
    ticket.client = client
    ticket.save
  end

  def return_ticket(ticket)
    ticket.client = nil
    ticket.save
  end

  def calculate_ticket_price(movie_screening)
    movie_info = movie_screening.movie.info
    release_date = movie_info.release_date
    duration = movie_info.duration
    (BASE_PRICE * (Float(duration) / 3600) -
      calculate_yearly_discount(release_date)).round(2)
  end

  def calculate_yearly_discount(release_date)
    current_year = Time.now.utc.year
    if release_date.year < current_year - BASE_DISCOUNT_START
      BASE_DISCOUNT * (Time.now.utc.year - release_date.year)
    else
      0
    end
  end
end
