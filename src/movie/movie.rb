require_relative 'movie_info'
require_relative 'movie_description.rb'
require_relative '../helpers/cinema_representation_helper.rb'

# class for storing information about cinema movie
class Movie
  attr_reader :info, :description
  def initialize(info, description)
    raise 'wrong parameter types' unless
    info.class.equal?(MovieInfo) &&
    description.class.equal?(MovieDescription)

    @info = info
    @description = description
  end

  def title
    description.title
  end

  def genre
    description.genre
  end

  def duration
    info.duration
  end

  def to_hash
    {
      info_id: info.object_id.to_s,
      description_id: description.object_id.to_s
    }
  end

  def to_s
    CinemaRepresentationHelper.stringify_movie(info, description)
  end

  def self.hash_create(serial, hash)
    new(serial.fetch('MovieInfo').fetch(hash.fetch('info_id')),
        serial.fetch('MovieDescription').fetch(hash.fetch('description_id')))
  end
end
