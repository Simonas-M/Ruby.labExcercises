# class for movie crew information
class MovieCrew
  attr_reader :directors, :writers, :actors
  def initialize(directors:, writers:, actors:)
    @directors = directors
    @writers = writers
    @actors = actors
  end

  def to_json
    %({"directors": "#{directors}",\
    "writers": "#{writers}",\
    "actors": "#{actors}"}).chomp
  end

  def self.create_from_hash(_serial, hash)
    new(directors: hash['directors'],
        writers: hash['writers'],
        actors: hash['actors'])
  end
end
