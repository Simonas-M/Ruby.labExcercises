require_relative '../../src/movie/movie_screening.rb'
require_relative '../../src/cinema_screen.rb'
require_relative '../helpers/movie_helper.rb'
require 'time'

RSpec.describe ':Movie Screening:' do
  before(:each) do
    @movie_screening = MovieScreening.new(
      movie: MovieHelper.create,
      cinema_screen: CinemaScreen.new(name: 'test', seat_count: 40),
      time: Time.now
    )
  end
  it 'should get movie screening available seat count' do
    expect(@movie_screening.available_seat_count).to eq(40)
  end
  it 'should decrease available seat count' do
    @movie_screening.reserve(1)
    expect(@movie_screening.available_seat_count).to eq(39)
  end
  it'should increase available seat count' do
    @movie_screening.reserve(4)
    @movie_screening.free(3)
    expect(@movie_screening.available_seat_count).to eq(39)
  end
  it 'should raise when reserving more seats then available' do
    @movie_screening.reserve(38)
    expect { @movie_screening.reserve(3) }
      .to raise_error('not enough free seats available')
  end
  it 'should raise when freeing more seats then reserved' do
    @movie_screening.reserve(5)
    expect { @movie_screening.free(6) }.to raise_error('cannon free 6 seats')
  end
  it 'should return false if not enough seats are available' do
    expect(@movie_screening.available?(50)).to be false
  end
  it 'should return true if there are enough seats are available' do
    expect(@movie_screening.available?(3)).to be true
  end
end
