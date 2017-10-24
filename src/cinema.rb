require_relative './cinema_repertoire.rb'

# Class for central cinema object
class Cinema
  attr_reader :cinema_screens
  def initialize(cinema_screens:)
    @cinema_screens = cinema_screens
    @repertoire = CinemaRepertoire.new
  end
end
