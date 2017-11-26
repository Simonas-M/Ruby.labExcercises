# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketManager, type: :model do
  fixtures :all

  before :each do
    @manager = ticket_manager(:manager)
  end

  it 'should calculate ticket price' do
    movie_screening = double('movie_screening')
    allow(movie_screening).to receive_message_chain(
      :movie, :info, release_date: Time.new('2005-12-12')
    )
    allow(movie_screening).to receive_message_chain(
      :movie, :info, duration: 8800
    )
    price = @manager.calculate_ticket_price(movie_screening)
    expect(price).to eq(6.29)
  end

  it 'should calculate yearly discount' do
    discount = @manager.calculate_yearly_discount(Time.utc.at(15555005000))
    expect(discount).to eq(0)
  end
end
