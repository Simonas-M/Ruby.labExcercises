require_relative 'movie_ratings.rb'
require 'time'

# movie information which contains rating, duration, release date, and crew
class MovieInfo
  attr_reader :rating, :duration, :release_date, :crew
  def initialize(rating:, duration:, release_date:, crew:)
    raise ArgumentError unless MovieRatings.include?(rating) &&
                               release_date.class == Time &&
                               crew.class == MovieCrew
    @rating = rating
    @duration = duration.to_i
    @release_date = release_date
    @crew = crew
  end
end
