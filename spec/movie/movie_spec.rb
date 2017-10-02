require_relative '../../src/movie/movie.rb'
require_relative '../../src/movie/movie_crew.rb'
require_relative '../../src/movie/movie_description.rb'
require_relative '../../src/movie/movie_info.rb'
require 'time'

describe '::Initialization' do
  it "shouldn't initialize without parameters" do
    expect { Movie.new }.to raise_error(ArgumentError)
  end
  it "shouldn't initialize without description" do
    expect { Movie.new(MovieInfo) }.to raise_error(ArgumentError)
  end
  it 'should initialize with MovieInfo and MovieDescription' do
    movie_crew = MovieCrew.new(
      directors: ['John'],
      writers: ['Bob'],
      actors: %w[Nick Susan]
    )
    movie_info = MovieInfo.new(
      rating: :PG,
      duration: 1000,
      release_date: Time.now,
      crew: movie_crew
    )
    movie_description = MovieDescription.new(
      title: 'title',
      genre: 'ACTION',
      summary: 'summary'
    )
    Movie.new(movie_info, movie_description)
  end
end

describe '::Functionality::' do
  before(:each) do
    @movie_crew = MovieCrew.new(
      directors: ['John'],
      writers: ['Bob'],
      actors: %w[Nick Susan]
    )
    @movie_info = MovieInfo.new(
      rating: :PG,
      duration: 1000,
      release_date: Time.now,
      crew: @movie_crew
    )
    @movie_description = MovieDescription.new(
      title: 'title',
      genre: 'ACTION',
      summary: 'summary'
    )
    @movie = Movie.new(@movie_info, @movie_description)
  end
  it 'should get movie title' do
    expect(@movie.title).to be(@movie_description.title)
  end
  it 'should get movie genre' do
    expect(@movie.genre).to be(@movie_description.genre)
  end
  it 'should get movie duration' do
    expect(@movie.duration).to be(@movie_info.duration)
  end
end
