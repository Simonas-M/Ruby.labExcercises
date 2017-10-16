require_relative '../../src/movie/movie_ticket.rb'
require_relative '../helpers/movie_helper.rb'
require 'time'

RSpec.describe 'MovieTicket' do
  before(:each) do
    @time = Time.now
    @movie = MovieHelper.create
    @movie_screening = MovieScreening.new(
      movie: @movie,
      cinema_screen: CinemaScreen.new(name: 'test', seat_count: 40),
      time: @time
    )
    @ticket = MovieTicket.new(
      price: '1.2',
      movie_screening: @movie_screening,
      seat_no: '33'
    )
  end

  it 'should raise if not MovieScreening object was passed' do
    expect do
      MovieTicket.new(
        price: '1.2',
        movie_screening: 'not',
        seat_no: '33'
      )
    end.to raise_error('MovieScreening object expected')
  end

  it 'should get the price' do
    expect(@ticket.price).to eq 1.2
  end

  it 'should get the movie screening' do
    expect(@ticket.movie_screening).to eq @movie_screening
  end

  it 'should get the seat number' do
    expect(@ticket.seat_no).to eq 33
  end
end
