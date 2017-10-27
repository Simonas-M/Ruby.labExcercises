require_relative '../../src/movie/movie_crew.rb'
require 'json'

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

  it 'should serialize to json' do
    serialized_hash = JSON.parse(@movie_crew.to_json)
    expect(serialized_hash['directors']).to eq(@movie_crew.directors)
    expect(serialized_hash['writers']).to eq(@movie_crew.writers)
    expect(serialized_hash['actors']).to eq(@movie_crew.actors)
  end

  it 'should deserialize json to object' do
    serialized_hash = {
      directors: %w[Papa John],
      writers: ['Lilly Wonka'],
      actors: %w[Frodo Bilbo Gandalf]
    }
    from_hash = MovieCrew.hash_create(nil, serialized_hash)
    expect(from_hash.directors).to eq %w[Papa John]
    expect(from_hash.writers).to eq ['Lilly Wonka']
    expect(from_hash.actors).to eq %w[Frodo Bilbo Gandalf]
  end
end
