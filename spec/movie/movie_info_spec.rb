require_relative '../../src/movie/movie_info.rb'
require_relative '../../src/movie/movie_crew.rb'
require 'time'

RSpec.describe '::Movie Info' do
  before(:each) do
    @info_args = {
      rating: :PG13,
      duration: 120_000,
      release_date: Time.new('2017-01-01'),
      crew: MovieCrew.new(
        directors: ['Uncle'],
        writers: ['Bob'],
        actors: %w[Rick Morty]
      )
    }
  end
  it 'should initialize' do
    expect(MovieInfo.new(@info_args)).to be
  end
  it 'should raise error if no arguments are passed' do
    expect { MovieInfo.new }.to raise_error(ArgumentError)
  end
end
