require_relative '../../src/session/serializer.rb'
require_relative '../../src/movie/movie_crew.rb'
require_relative '../../src/movie/movie_info.rb'

RSpec.describe 'Serializer' do
  it 'should seralize an object array' do
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
    Serializer.serialize_all([@movie_crew, @movie_info])
  end
end
