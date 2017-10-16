require_relative '../../src/movie/movie_info.rb'
require_relative '../../src/movie/movie_crew.rb'
require 'time'

RSpec.describe 'MovieInfo' do
  before(:each) do
    @movie_crew = MovieCrew.new(
      directors: ['Uncle'],
      writers: ['Bob'],
      actors: %w[Rick Morty]
    )
    @info_args = {
      rating: :PG13,
      duration: '120_000',
      release_date: Time.new('2017-01-01'),
      crew: @movie_crew
    }
    @movie_info = MovieInfo.new(@info_args)
  end
  it 'should initialize' do
    expect(MovieInfo.new(@info_args)).to be
  end
  it 'should raise error if wrong parameters are passed' do
    # no parameters
    expect { MovieInfo.new }.to raise_error(ArgumentError)
    # wrong rating
    expect { MovieInfo.new({
      rating: :HAHA,
      duration: '120_000',
      release_date: Time.new('2017-01-01'),
      crew: @movie_crew
    }) }.to raise_error('wrong parameter types')
    # wrong release_date
    expect { MovieInfo.new({
      rating: :PG13,
      duration: '120_000',
      release_date: 'not time',
      crew: @movie_crew
    }) }.to raise_error('wrong parameter types')
    # wrong crew
    expect { MovieInfo.new({
      rating: :PG13,
      duration: '120_000',
      release_date: Time.new('2017-01-01'),
      crew: 'not movie_crew'
    }) }.to raise_error('wrong parameter types')
  end
  it 'should get rating' do
    expect(@movie_info.rating).to eq(:PG13)
  end
  it 'should get duration' do
    expect(@movie_info.duration).to eq(120_000)
  end
  it 'should get release date' do
    expect(@movie_info.release_date).to eq(Time.new('2017-01-01'))
  end
  it 'should get crew' do
    expect(@movie_info.crew).to eq(@movie_crew)
  end
end
