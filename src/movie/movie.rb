require_relative 'movie_info'
require_relative 'movie_description.rb'

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

  def to_json
    %({"info": "#{info.objet_id}",\
    "description": "#{description.object_id}"}).chomp
  end

  def self.create_from_hash(serial, hash)
    new(info: serial['MovieInfo'][hash['info_id']],
        description: serial['MovieDescription'][hash['description_id']])
  end
end
