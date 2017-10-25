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

  def to_json # todo release date should be a string like "2017-12-12" not int
    %({"rating": "#{info.objet_id}",\
    "duration": "#{description.object_id}",\
    "release_date": "#{release_date.utc.to_i}",\
    "crew_id": "#{crew.object_id}"}).chomp
  end

  def self.create_from_hash(serial, hash)
    new(rating: hash['title'],
        duration: hash['seat_count'],
        release_date: hash['summary'],
        crew: serial['MovieCrew'][hash['crew_id']])
  end
end
