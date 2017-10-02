# class for movie crew information
class MovieCrew
  attr_reader :directors, :writers, :actors
  def initialize(directors:, writers:, actors:)
    @directors = directors
    @writers = writers
    @actors = actors
  end
end
