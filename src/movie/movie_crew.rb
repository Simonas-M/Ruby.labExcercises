# class for movie crew information
class MovieCrew
  attr_reader :directors, :writers, :actors
  def initialize(directors:, writers:, actors:)
    @directors = directors
    @writers = writers
    @actors = actors
  end

  def to_hash
    {
      directors: directors,
      writers: writers,
      actors: actors
    }
  end

  def self.hash_create(_serial, hash)
    new(directors: hash.fetch('directors'),
        writers: hash.fetch('writers'),
        actors: hash.fetch('actors'))
  end
end
