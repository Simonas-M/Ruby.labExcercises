# frozen_string_literal: true

require_relative '../app_helpers/ticket_price_calculator.rb'

# Class for managing bought tickets
class TicketManager < ApplicationRecord
  belongs_to :cinema
  has_many :tickets

  # def reserve_ticket(client, ticket)

  # end

  def client_ellegible_for_free_ticket?(client)
    ticket_count = tickets.where(client: client).count
    TicketPriceCalculator.free_ticket_elllegible? ticket_count
  end

  def adjust_price_for_client(client:, ticket_id:)
    ticket = tickets.find_by!(id: ticket_id)
    new_price = if client_ellegible_for_free_ticket?(client)
                  0
                else
                  TicketPriceCalculator.calculate_ticket_price(ticket.screening)
                end
    ticket.change_price(new_price)
  end

  def create_ticket(screening:, seat_no:)
    Ticket.create!(
      seat_no: seat_no,
      screening: screening,
      ticket_manager: self
    )
  end

  def assign_ticket(ticket:, client:)
    begin
      tm_ticket = tickets.find_by!(id: ticket.id, client: nil)
    rescue
      raise 'cannot reassign ticket'
    end
    tm_ticket.assign_to(client: client)
  end

  def return_ticket(ticket)
    tm_ticket = tickets.find_by!(id: ticket.id)
    tm_ticket.unassign
  end
end
