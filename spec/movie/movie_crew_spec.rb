require_relative '../../src/movie/movie_crew.rb'

RSpec.describe 'MovieCrew' do
  before(:each) do
    @crew_args = {
      directors: %w[Adam John],
      writers: ['George'],
      actors: %w[Billy Eve Cornelia]
    }
    @movie_crew = MovieCrew.new(@crew_args)
  end
  it 'should initialize' do
    movie_crew = MovieCrew.new(@crew_args)
    expect(movie_crew).to be
  end
  it 'should raise error if no arguments are passed' do
    expect { MovieCrew.new }.to raise_error(ArgumentError)
  end
  it 'should get directors' do
    expect(@movie_crew.directors).to eq %w[Adam John]
    expect(@movie_crew.writers).to eq ['George']
    expect(@movie_crew.actors).to eq %w[Billy Eve Cornelia]
  end
end
