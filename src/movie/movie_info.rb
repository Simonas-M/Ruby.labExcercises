require_relative 'movie_ratings.rb'
require 'time'

# movie information which contains rating, duration, release date, and crew
class MovieInfo
  attr_reader :rating, :duration, :release_date, :crew
  def initialize(rating:, duration:, release_date:, crew:)
    raise 'wrong parameter types' unless MovieRatings.include?(rating) &&
                                         release_date.class.equal?(Time) &&
                                         crew.class.equal?(MovieCrew)
    @rating = rating.to_sym.upcase
    @duration = Integer(duration)
    @release_date = release_date
    @crew = crew
  end

  def to_hash
    {
      rating: rating.to_s,
      duration: duration,
      release_date: release_date.utc.strftime('%Y-%m-%d'),
      crew_id: crew.object_id.to_s
    }
  end

  def self.hash_create(serial, hash)
    new(rating: hash.fetch('rating'),
        duration: hash.fetch('duration'),
        release_date: Time.utc(hash.fetch('release_date')),
        crew: serial.fetch('MovieCrew').fetch(hash.fetch('crew_id')))
  end
end
