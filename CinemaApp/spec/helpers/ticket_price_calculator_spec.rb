# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketPriceCalculator, type: :helper do
  it 'should not apply yearly discount' do
    release_date = Time.new(2000, 1, 1).utc
    allow(DatetimeHelper).to receive(:current_year).and_return(2010)
    discount = TicketPriceCalculator.calculate_yearly_discount(release_date)
    expect(discount).to eq 0.957
  end

  it 'should calculate yearly discount' do
    release_date = Time.new(2009, 1, 1).utc
    allow(DatetimeHelper).to receive(:current_year).and_return(2010)
    discount = TicketPriceCalculator.calculate_yearly_discount(release_date)
    expect(discount).to eq 0
  end

  it 'should calculate ticket price' do
    movie_screening = double('movie_screening')
    allow(movie_screening).to receive_message_chain(
      :movie, :info, release_date: Time.new('2005-12-12').utc
    )
    allow(movie_screening).to receive_message_chain(
      :movie, :info, duration: 8800
    )
    price = TicketPriceCalculator.calculate_ticket_price(movie_screening)
    expect(price).to eq(6.2)
  end
end
