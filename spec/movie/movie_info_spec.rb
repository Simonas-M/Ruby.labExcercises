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
      rating: 'pg13',
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
    expect do
      MovieInfo.new(
        rating: :HAHA,
        duration: '120_000',
        release_date: Time.new('2017-01-01'),
        crew: @movie_crew
      )
    end.to raise_error('wrong parameter types')
    # wrong release_date
    expect do
      MovieInfo.new(
        rating: :PG13,
        duration: '120_000',
        release_date: 'not time',
        crew: @movie_crew
      )
    end.to raise_error('wrong parameter types')
    # wrong crew
    expect do
      MovieInfo.new(
        rating: :PG13,
        duration: '120_000',
        release_date: Time.new('2017-01-01'),
        crew: 'not movie_crew'
      )
    end.to raise_error('wrong parameter types')
  end

  it 'should get rating as upcase symbol' do
    expect(@movie_info.rating).to eq :PG13
  end

  it 'should serialize to hash' do
    serialized_hash = @movie_info.to_hash
    expect(serialized_hash[:rating]).to eq(@movie_info.rating.to_s)
    expect(serialized_hash[:duration]).to eq(@movie_info.duration)
    expect(serialized_hash[:release_date])
      .to eq(@movie_info.release_date.utc.strftime('%Y-%m-%d'))
    expect(serialized_hash[:crew_id]).to eq(@movie_info.crew.object_id.to_s)
  end

  it 'should deserialize hash to object' do
    serialized_hash = {
      'MovieCrew' => {
        '80085' => @movie_crew
      },
      'MovieInfo' => {
        'rating' => 'PG13',
        'duration' => 120_000,
        'release_date' => '2017-01-01',
        'crew_id' => '80085'
      }
    }
    from_hash = MovieInfo
                .hash_create(serialized_hash, serialized_hash['MovieInfo'])
    expect(from_hash.rating).to eq :PG13
    expect(from_hash.duration).to eq 120_000
    expect(from_hash.release_date).to eq Time.utc('2017-01-01')
    expect(from_hash.crew).to eq @movie_crew
  end
end
