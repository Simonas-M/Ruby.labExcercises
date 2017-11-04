require_relative '../../src/session/serializer.rb'
require_relative '../../src/movie/movie_crew.rb'
require_relative '../../src/movie/movie_info.rb'

RSpec.describe 'Serializer' do
  before(:each) do
    @movie_crew = MovieCrew.new(
      directors: ['Uncle'],
      writers: ['Bob'],
      actors: %w[Rick Morty]
    )
    @movie_info = MovieInfo.new(
      rating: 'pg13',
      duration: '120_000',
      release_date: Time.new('2017-01-01'),
      crew: @movie_crew
    )
  end

  it 'should seralize an object' do
    result = Serializer.serialize(@movie_crew)
    expected_result = {
      directors: ['Uncle'],
      writers: ['Bob'],
      actors: %w[Rick Morty]
    }
    expect(result).to eq expected_result
  end

  it 'should serialize an object array' do
    result = Serializer.serialize_all([@movie_crew, @movie_info])
    expect(result).to eq %({"MovieCrew":{"1":{"directors":["Uncle"],"writers":[\
"Bob"],"actors":["Rick","Morty"]}},"MovieInfo":{"2":{"rating":"PG13","duration"\
:120000,"release_date":"2016-12-31","crew_id":"1"}}})
  end
end
