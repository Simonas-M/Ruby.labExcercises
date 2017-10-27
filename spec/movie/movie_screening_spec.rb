require_relative '../../src/movie/movie_screening.rb'
require_relative '../../src/cinema_screen.rb'
require_relative '../helpers/movie_helper.rb'
require 'time'

RSpec.describe 'MovieScreening' do
  before(:each) do
    @time = Time.now
    @movie = MovieHelper.create
    @cinema_screen = CinemaScreen.new(name: 'test', seat_count: 40)
    @movie_screening = MovieScreening.new(
      movie: @movie,
      cinema_screen: @cinema_screen,
      time: @time
    )
  end
  it 'should convert time to utc' do
    expect(@movie_screening.time.utc?).to eq true
  end
  it 'should decrease and increase available seat count' do
    @movie_screening.reserve('3')
    expect(@movie_screening.available_seat_count).to eq(37)
    @movie_screening.free('2')
    expect(@movie_screening.available_seat_count).to eq(39)
  end
  it'should increase available seat count' do
    @movie_screening.reserve('40')
    @movie_screening.free('40')
    expect(@movie_screening.available_seat_count).to eq(40)
  end
  it 'should raise when reserving more seats then available' do
    @movie_screening.reserve('38')
    expect { @movie_screening.reserve('3') }
      .to raise_error('not enough free seats available')
  end
  it 'should raise when freeing more seats then reserved' do
    @movie_screening.reserve('5')
    expect { @movie_screening.free('6') }.to raise_error('cannon free 6 seats')
  end
  it 'should return false if not enough seats are available' do
    expect(@movie_screening.available?(50)).to be false
  end
  it 'should return true if there are enough seats are available' do
    expect(@movie_screening.available?(3)).to be true
    expect(@movie_screening.available?(40)).to be true
  end

  it 'should serialize to json' do
    serialized_hash = JSON.parse(@movie_screening.to_json)
    expect(serialized_hash['movie_id'])
      .to eq(@movie_screening.movie.object_id.to_s)
    expect(serialized_hash['cinema_screen_id'])
      .to eq(@movie_screening.cinema_screen.object_id.to_s)
    expect(serialized_hash['time'])
      .to eq(@movie_screening.time.utc.to_i)
    expect(serialized_hash['available_seat_count'])
      .to eq(@movie_screening.available_seat_count)
  end

  it 'should deserialize hash to object' do
    serialized_hash = {
      Movie: {
        '001' => @movie
      },
      CinemaScreen: {
        '123' => @cinema_screen
      },
      MovieScreening: {
        movie_id: '001',
        cinema_screen_id: '123',
        time: 1_509_112_692
      }
    }
    from_hash = MovieScreening
                .hash_create(serialized_hash, serialized_hash[:MovieScreening])
    expect(from_hash.movie).to eq @movie
    expect(from_hash.cinema_screen).to eq @cinema_screen
    expect(from_hash.time).to eq Time.at(1_509_112_692).utc
    expect(from_hash.available_seat_count).to eq 40
  end
end
