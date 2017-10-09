require_relative 'movie_ratings.rb'
require 'time'

# movie information which contains rating, duration, release date, and crew
class MovieInfo
  attr_reader :rating, :duration, :release_date, :crew
  def initialize(rating:, duration:, release_date:, crew:)
    raise 'wrong parameter types' unless MovieRatings.include?(rating) &&
                                         release_date.class.equal?(Time) &&
                                         crew.class.equal?(MovieCrew)
    @rating = rating
    @duration = Integer(duration)
    @release_date = release_date
    @crew = crew
  end
end
