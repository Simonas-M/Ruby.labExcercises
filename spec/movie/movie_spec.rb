require_relative '../../src/movie/movie.rb'
require_relative '../../src/movie/movie_crew.rb'
require_relative '../../src/movie/movie_description.rb'
require_relative '../../src/movie/movie_info.rb'
require 'time'

RSpec.describe 'Movie' do
  before(:each) do
    movie_crew = MovieCrew.new(
      directors: ['John'],
      writers: ['Bob'],
      actors: %w[Nick Susan]
    )
    @movie_info = MovieInfo.new(
      rating: :PG,
      duration: 1000,
      release_date: Time.now,
      crew: movie_crew
    )
    @movie_description = MovieDescription.new(
      title: 'title',
      genre: 'ACTION',
      summary: 'summary'
    )
  end

  it "shouldn't initialize without parameters" do
    expect { Movie.new }.to raise_error(ArgumentError)
  end

  it "shouldn't initialize without description" do
    expect { Movie.new(@movie_info) }.to raise_error(ArgumentError)
  end

  it "shouldn't initialize with wrong parameters" do
    expect { Movie.new(@movie_info, 'b') }
      .to raise_error('wrong parameter types')
    expect { Movie.new('a', @movie_description) }
      .to raise_error('wrong parameter types')
    expect { Movie.new('a', 'b') }.to raise_error('wrong parameter types')
  end

  it 'should initialize with MovieInfo and MovieDescription' do
    movie = Movie.new(@movie_info, @movie_description)
    expect(movie.title).to eq 'title'
    expect(movie.genre).to eq :ACTION
    expect(movie.duration).to eq 1000
  end

  it 'should serialize to hash' do
    movie =  Movie.new(@movie_info, @movie_description)
    serialized_hash = movie.to_hash
    expect(serialized_hash[:info_id]).to eq(movie.info.object_id.to_s)
    expect(serialized_hash[:description_id])
      .to eq(movie.description.object_id.to_s)
  end

  it 'should deserialize hash to object' do
    serialized_hash = {
      'Movie' => {
        'info_id' => '002',
        'description_id' => '002'
      },
      'MovieInfo' => {
        '002' => @movie_info
      },
      'MovieDescription' => {
        '002' => @movie_description
      }
    }
    from_hash = Movie.hash_create(serialized_hash, serialized_hash['Movie'])
    expect(from_hash.info).to eq @movie_info
    expect(from_hash.description).to eq @movie_description
  end

  it 'should stringify' do
    movie = Movie.new(@movie_info, @movie_description)
    expect(movie.to_s)
      .to eq "\nTitle (2017)\nPG | 00h 16min | ACTION | 2017-10-29\nsummary"
  end
end
