# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketManager, type: :model do
  fixtures :all

  before :each do
    @manager = ticket_manager(:manager)
  end

  it 'should create new ticket' do
    screening = screenings(:inception_screening)
    @manager.create_ticket(screening: screening, seat_no: 3)
    expect(@manager.tickets.find_by!(screening: screening, seat_no: 3)).to be
  end

  it 'should assign ticket to client' do
    ticket = tickets(:inception_ticket1)
    client = clients(:Bobby)
    @manager.assign_ticket(client: client, ticket: ticket)
    expect(Ticket.find(ticket.id).client).to eq(client)
  end

  it 'should not assign ticket if ticket already has a client' do
    ticket = tickets(:inception_ticket1)
    client = clients(:Bobby)
    @manager.assign_ticket(client: client, ticket: ticket)
    expect do
      @manager.assign_ticket(client: client,
                             ticket: Ticket.find(ticket.id))
    end.to raise_error 'cannot reassign ticket'
  end

  it 'should unassign ticket' do
    ticket = tickets(:inception_ticket1)
    client = clients(:Bobby)
    @manager.assign_ticket(client: client, ticket: ticket)

    assigned = Ticket.find(ticket.id)
    @manager.return_ticket(assigned)
    expect(Ticket.find(ticket.id).client).to be_nil
  end

  it 'should change price according to client' do
    ticket = tickets(:inception_ticket1)
    client = clients(:Bobby)
    @manager.adjust_price_for_client(client: client, ticket_id: ticket.id)
    changed_ticket = Ticket.find(ticket.id)
    expect(changed_ticket.price).to eq 0.672e1
  end

  it 'should change price according to client' do
    ticket = tickets(:inception_ticket1)
    client = clients(:Bobby)
    7.times do
      Ticket.create(seat_no: ticket.seat_no, screening: ticket.screening,
                    ticket_manager: @manager, client: client)
    end
    @manager.adjust_price_for_client(client: client, ticket_id: ticket.id)
    changed_ticket = Ticket.find(ticket.id)
    expect(changed_ticket.price).to eq 0
  end

  it 'should handle every 7th ticket price to be free' do
    client = clients(:Susan)
    ticket = tickets(:inception_ticket1)
    7.times do
      Ticket.create(seat_no: ticket.seat_no, screening: ticket.screening,
                    ticket_manager: @manager, client: client)
    end

    expect(@manager)
      .to receive(:client_ellegible_for_free_ticket?).and_call_original
    expect(TicketPriceCalculator).not_to receive(:calculate_ticket_price)
    @manager.adjust_price_for_client(client: client, ticket_id: ticket.id)
  end

  it 'should handle every not 7th ticket price' do
    client = clients(:Susan)
    ticket = tickets(:inception_ticket1)

    expect(@manager)
      .to receive(:client_ellegible_for_free_ticket?).and_call_original
    expect(TicketPriceCalculator).to receive(:calculate_ticket_price)
    @manager.adjust_price_for_client(client: client, ticket_id: ticket.id)
  end

  it 'should tell if client is ellegible for a free ticket' do
    client = clients('Susan')
    expect(@manager.client_ellegible_for_free_ticket?(client)).to be false
  end

  it 'should tell if client is ellegible for a free ticket' do
    client = clients('Susan')
    ticket = tickets(:inception_ticket1)
    7.times do
      Ticket.create(seat_no: ticket.seat_no, screening: ticket.screening,
                    ticket_manager: @manager, client: client)
    end

    expect(@manager.client_ellegible_for_free_ticket?(client)).to be true
  end
end
