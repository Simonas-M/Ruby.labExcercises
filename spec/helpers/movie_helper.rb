require 'time'
require_relative '../../src/movie/movie.rb'
require_relative '../../src/movie/movie_crew.rb'
require_relative '../../src/movie/movie_info.rb'
require_relative '../../src/movie/movie_description.rb'

# class for creating Movie objects for test cases
class MovieHelper
  def self.create(title: 'default')
    movie_crew = MovieCrew.new(
      directors: ['Uncle'],
      writers: ['Bob'],
      actors: %w[Rick Morty]
    )
    movie_info = MovieInfo.new(:PG, 10_000, Time.utc(2015, 1, 1), movie_crew)
    movie_description = MovieDescription.new(
      title: title,
      genre: 'ACTION',
      summary: 'summary'
    )
    Movie.new(movie_info, movie_description)
  end
end
