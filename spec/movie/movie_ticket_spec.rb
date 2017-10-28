require_relative '../../src/movie/movie_ticket.rb'
require_relative '../helpers/movie_helper.rb'
require_relative '../../src/cinema_screen.rb'
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

  it 'should serialize to json' do
    serialized_hash = @ticket.to_hash
    expect(serialized_hash[:price])
      .to eq(@ticket.price)
    expect(serialized_hash[:movie_screening_id])
      .to eq(@ticket.movie_screening.object_id.to_s)
    expect(serialized_hash[:seat_no])
      .to eq(@ticket.seat_no)
  end

  it 'should deserialize hash to object' do
    serialized_hash = {
      'MovieScreening' => {
        '155' => @movie_screening
      },
      'MovieTicket' => {
        'price' => 4.55,
        'movie_screening_id' => '155',
        'seat_no' => 3
      }
    }
    from_hash = MovieTicket
                .hash_create(serialized_hash, serialized_hash['MovieTicket'])
    expect(from_hash.price).to eq 4.55
    expect(from_hash.movie_screening).to eq @movie_screening
    expect(from_hash.seat_no).to eq 3
  end
end
