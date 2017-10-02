require_relative '../../src/movie/movie_crew.rb'

describe '::Movie Crew' do
  before(:each) do
    @crew_args = {
      directors: %w[Adam John],
      writers: ['George'],
      actors: %w[Billy Eve Cornelia]
    }
  end
  it 'should initialize' do
    movie_crew = MovieCrew.new(@crew_args)
    expect(movie_crew).to be
  end
  it 'should raise error if no arguments are passed' do
    expect { MovieCrew.new }.to raise_error(ArgumentError)
  end
end
